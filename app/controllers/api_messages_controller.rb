class ApiMessagesController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages.json
  def index
    @channel = Channel.find_by_id(params[:channel_id])
    # if the current user doesn't have the event...
    if @channel.nil? || current_user.events.find_by_id(@channel.event.id).nil?
      render json: { status: "failure", error: "Channel not found, or unauthorized." }
    else
      @messages = @channel.messages
      render json: { status: "success", data: @messages }
    end
  end

  # GET /messages/1.json
  def show
    if @message.nil? || current_user.events.find_by_id(@message.channel.event.id).nil?
      render json: { status: "failure", error: "Message not found, or unauthorized." }
    else
      render json: { status: "success", data: @message }
    end
  end

  # POST /messages.json
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
      @message = @channel.messages.new(message_params)

      if @message.save
        render json: { status: "success", data: @message }
      else
        render json: { status: "failure", data: @message.errors }
      end
    end
  end

  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.json { render :show, status: :ok, location: @message }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message_guts)
    end
end
