class ApiMessagesController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages.json
  def index
    @messages = Channel.find(params[:channel_id]).messages
    render json: { status: "success", data: @messages }
  end

  # GET /messages/1.json
  def show
    render json: { status: "success", data: @message }
  end

  # POST /messages.json
  def create
    @channel = Channel.find(params[:channel_id])
    @message = @channel.messages.new(message_params)

    if @message.save
      render json: { status: "success", data: @message }
    else
      render json: { status: "failure", data: @message.errors }
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
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message_guts)
    end
end
