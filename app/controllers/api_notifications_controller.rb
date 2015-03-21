class ApiNotificationsController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications.json
  def index
    @channel = Channel.find_by_id(params[:channel_id])
    # if the current user doesn't have the event...
    if @channel.nil? || current_user.events.find_by_id(@channel.event.id).nil?
      render json: { status: "failure", error: "Channel not found, or unauthorized." }
    else
      @notifications = @channel.notifications
      render "notifications/index"
    end
  end

  # GET /notifications/1.json
  def show
    if @notification.nil? || current_user.events.find_by_id(@notification.channel.event.id).nil?
      render json: { status: "failure", error: "Notification not found, or unauthorized." }
    else
      render "notifications/show"
    end
  end

  # POST /notification.json
  def create
    @channel = Channel.find_by_id(params[:channel_id])

    # hacky way of assigning subscription, since if channel is nil, then
    # @channel.event fails
    subscription = @channel.nil? ? nil :
      current_user.subscriptions.where(event_id: @channel.event.id).first

    # either the channel doesn't exist, the user isn't subscribed to the event,
    # or the user isn't an admin on the event
    if @channel.nil? || subscription.nil? ||(not subscription.admin)
      render json: { status: "failure", error: "Channel not found, or unauthorized." }
    else
      begin
        @notification = @channel.notifications.new(notification_params)
        if @notification.save
          if @notification.is_a?(Survey)
            # if there are no options, or if it isn't an array...
            if option_params.empty? || (not option_params.is_a?(Array))
              render json: { status: "failure", data: "Cannot create survey without options." }
              return
            end
            for option in option_params
              begin
                @notification.options.create!(option_guts: option.to_s)
              rescue ActiveRecord::RecordInvalid
                render json: { status: "failure", data: "One of the options failed validation." }
                @notification.destroy!
                return
              end
            end
          end
          render "notifications/show"
        else
          render json: { status: "failure", data: @notification.errors }
        end
      rescue ActiveRecord::SubclassNotFound
        # if it failed with SubclassNotFound, then it must have had the wrong type
        render json: { status: "failure", data: "Type must be of Message or Survey." }
      end
    end
  end

  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.json { render :show, status: :ok, location: @notification }
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:notification_guts, :type)
    end

    def option_params
      params.require(:options)
    end
end
