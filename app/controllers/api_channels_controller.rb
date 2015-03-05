class ApiChannelsController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels.json
  def index
    @channels = Event.find(params[:event_id]).channels
    render json: { status: "success", data: @channels }
  end

  # GET /channels/1.json
  def show
    render json: { status: "success", data: @channel }
  end

  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.json { render :show, status: :created, location: @channel }
      else
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.json { render :show, status: :ok, location: @channel }
      else
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params[:channel]
    end
end
