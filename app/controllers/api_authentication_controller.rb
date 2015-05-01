class ApiAuthenticationController < ApplicationController
  before_action :authenticate_user!, only: [
    :get_authentication_token
  ]

  def login
    @user = User.where(email: params[:email]).first
    if not @user.nil? and @user.valid_password?(params[:password])
      if params[:ios]
        render json: { status: "success", data: @user.as_json(
          include: {
            events: {
              include: {
                channels: {include: :notifications },
                subevents: {},
              }
            } 
          }
        )}
      else
        render json: { status: "success", data: @user.as_json(
          include: {
            events: {
              include: {
                channels: {},
              }
            } 
          }
        )}
      end
    else
      render json: { status: "failure" }
    end
  end

  def login_with_token
    @user = User.where(email: params[:email]).first
    if not @user.nil? and @user.authentication_token == params[:token]
      render json: { status: "success", data: @user.as_json(include: { events: { include: :channels } }) }
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
        # fb token is valid, so create user and render
        @user.facebook_token = params[:facebook_token]
        @user.password = SecureRandom.uuid
        @user.skip_confirmation!
        @user.save!
        # automatically subscribe to all events, for testing purposes
        for e in Event.all
          @user.subscriptions.create!(event_id: e.id, admin: false)
        end
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
    render json: { status: "success", data: @user.as_json(include: { events: { include: :channels } }) }
  end

  def register
    @user = User.new(email: params[:email], password: params[:password])
    if @user.valid?
      @user.skip_confirmation!
      @user.save!
      render json: { status: "success", data: @user.as_json(include: { events: { include: :channels } }) }
    else
      render json: { status: "failure", error: "User invalid." }
    end
  end

  def get_authentication_token
    render json: { status: "success", data: { authentication_token: current_user.authentication_token } }
  end
end
