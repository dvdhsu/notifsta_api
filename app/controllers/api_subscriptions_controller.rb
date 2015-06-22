class ApiSubscriptionsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :verify_logged_in
  before_action :set_subscription, only: [:show, :flip_admin, :destroy]

  def index
    # unfortunately, Cancancan is of no help here...
    # https://github.com/ryanb/cancan/wiki/Authorizing-controller-actions
    @event = Event.find_by_id(params[:event_id])
    if @event.nil? || (@event.admins.where(user_id: current_user.id).empty? && (not current_user.admin?))
      render json: { status: "failure", error: "Event not found, or unauthorized." }
    else
      @joined = @event.subscriptions.joins(:user).select('users.email, subscriptions.*')
      render json: { status: "success", data: @joined.as_json }
    end
  end

  # GET /subscriptions/1.json
  def show
    authorize! :show, @subscription
    if @subscription.nil?
      render json: { status: "failure", error: "Subscription not found." }
    else
      render json: { status: "success", data: @subscription.as_json }
    end
  end

  def flip_admin
    if @subscription.nil?  || (@subscription.event.admins.where(user_id: current_user.id).empty? && (not current_user.admin?))
      render json: { status: "failure", error: "Subscription not found, or unauthorized." }
    else
      @subscription.admin = (not @subscription.admin)
      @subscription.save!
      render json: { status: "success", data: @subscription }
    end
  end

  # POST /subscriptions.json
  def create
    @subscription = current_user.subscriptions.new(event_id: params[:event_id], admin: false)
    authorize! :create, @subscription

    if @subscription.save
      render json: { status: "success", data: @subscription.as_json }
    else
      render json: { status: "failure", error: "Subscription not valid." }
    end
  end

  # DELETE /subscriptions/1.json
  def destroy
    authorize! :destroy, @subscription
    @subscription.destroy!
    render json: { status: "success" }
  end

  def delete_by_event_id
    @subscription = current_user.subscriptions.where(event_id: params[:event_id]).first
    authorize! :destroy, @subscription
    @subscription.destroy!
    render json: { status: "success" }
  end

  def set_subscription
    @subscription = Subscription.find_by_id(params[:id])
  end
end
