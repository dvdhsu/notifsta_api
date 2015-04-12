class ApiEventsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :verify_logged_in

  # GET /events.json
  # maybe allow for site admins later on?
=begin
  def index
    @events = Event.all
    render json: { status: "success", data: @events }
  end
=end

  # GET /events/1.json
  def show
    # ensure that the current user has access to the event
    # namely, that he / she is subscribed to it
    if @event.nil? || current_user.events.find_by_id(@event.id).nil?
      render json: { status: "failure", error: "Event not found, or unauthorized." }
    else
      render json: { status: "success", data: @event.as_json(include: {channels: {include: :notifications}}) }
    end
  end

  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.json { render :show, status: :created, location: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render :show, status: :ok, location: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event]
    end
end
