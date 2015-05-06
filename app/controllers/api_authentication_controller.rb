class ApiAuthenticationController < ApplicationController
  before_action :authenticate_user!, only: [
    :get_authentication_token
  ]

  def login
    @user = User.where(email: params[:email]).first
    if not @user.nil? and @user.valid_password?(params[:password])
      render_user(@user)
    else
      render json: { status: "failure" }
    end
    return
  end

  def login_with_token
    @user = User.where(email: params[:email]).first
    if not @user.nil? and @user.authentication_token == params[:token]
      render_user(@user)
    else
      render json: { status: "failure" }
    end
  end


  def logout
    @user = User.where(authentication_token: params[:authentication_token]).first
    if not @user.nil?
      @user.authentication_token = nil
      @user.save!
      render json: { status: "success" }
    else
      render json: { status: "failure" }
    end
  end

  def facebook_register_or_login

    @user = User.where(facebook_id: params[:facebook_id]).first
    if @user.nil?
      @user = User.new(
        facebook_id: params[:facebook_id],
        email: params[:email],
      )
      if @user.check_facebook_token(params[:facebook_token])
        # if the user already exists, let's just add facebook_token to their
        # account
        @user_with_email = User.where(email: params[:email]).first
        if @user_with_email
          # the user previously had an account with us, under their email
          @user_with_email.facebook_token = params[:facebook_token]
          @user_with_email.facebook_id = params[:facebook_id]
          render_user(@user_with_email)
          return
        end

        # fb token is valid, so create user and render
        @user.facebook_token = params[:facebook_token]
        @user.password = SecureRandom.uuid
        @user.skip_confirmation!
        @user.save!
        # automatic subscribe to SHB
        @user.subscriptions.create!(event_id: 1, admin: false)
      else
        render json: { status: "failure", error: "Facebook token invalid." }
        return
      end
    else
      # we've found the linked account, and now check the token
      if not @user.check_facebook_token(params[:facebook_token])
        render json: { status: "failure", error: "Facebook token invalid." }
        return
      end
    end
    # user created, and facebook token is valid
    render_user(@user)
  end

  def register
    @user = User.new(email: params[:email], password: params[:password])
    if @user.valid?
      @user.skip_confirmation!
      @user.save!
      @user.subscriptions.create!(event_id: 1, admin: false)
      render_user(@user)
    else
      render json: { status: "failure", error: "User invalid." }
    end
  end

  def get_authentication_token
    render json: { status: "success", data: { authentication_token: current_user.authentication_token } }
  end

  private
    def render_user(user)
      @all_event_ids = Event.all.pluck(:id)
      @my_event_ids = user.subscriptions.pluck(:event_id)
      @my_events = Event.find(@my_event_ids)
      @not_my_events = Event.find(@all_event_ids - @my_event_ids)


      if params[:ios]
        data = user.as_json
        data["events"]  = {
          "subscribed" => @my_events.as_json(include: { channels: { include: :notifications }}), 
          "not_subscribed" => @not_my_events.as_json(include: { channels: { include: :notifications }})
        }
        puts data["events"]
        for event in data["events"]["subscribed"]
          @event = Event.find(event["id"].to_i)
          @subevents = @event.subevents.group_by { |s| s.start_time.to_formatted_s(:iso8601) }
          event["subevents"] = @subevents.as_json
        end
        for event in data["events"]["not_subscribed"]
          @event = Event.find(event["id"].to_i)
          @subevents = @event.subevents.group_by { |s| s.start_time.to_formatted_s(:iso8601) }
          event["subevents"] = @subevents.as_json
        end
        render json: { status: "success", data: data }
      else
        data = user.as_json(
          include: {
            events: {
              include: {
                channels: {},
              }
            }
          }
        )
        data["subscriptions"] = user.subscriptions.as_json
        render json: { status: "success", data: data }
      end
    end
end
