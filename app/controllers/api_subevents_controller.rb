class ApiSubeventsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :verify_logged_in
  before_action :set_event, only: [:index, :create]
  before_action :set_subevent, only: [:update, :destroy]
  before_action :parse_dates, only: [:update, :create]


  # GET /subevents.json
  def index
    # if the user doesn't have the event...
    if @event.nil? || current_user.events.find_by_id(@event.id).nil?
      render json: { status: "failure", error: "Event not found, or unauthorized." }
    else
      @subevents = @event.subevents.group_by { |s| s.start_time.inspect }
      render json: { status: "success", data: @subevents }
    end
  end

  # POST /suvevents.json
  def create
    if not (@start_time and @end_time)
      render json: { status: "failure", error: "Start / end datetime not valid." }
      # probably check if in between start_time and end_time of event
      return
    end

    @subevent = @event.subevents.new(
      start_time: @start_time,
      end_time: @end_time,
      name: params[:name],
      location: params[:location],
      description: params[:description],
    )

    authorize! :manage, @subevent

    if @subevent.save
      render json: { status: "success", data: @subevent.as_json }
    else
      render json: { status: "failure", error: "Subevent not valid." }
    end
  end

  # DELETE /subevents/1.json
  def destroy
    authorize! :manage, @subevent
    @subevent.destroy!
    render json: { status: "success" }
  end

=begin
TODO: @subevent.update doesn't work if a certain param is nil.
Change this to use strong parameters
  def update
    authorize! :manage, @subevent
    if @subevent.update(
      start_time: @start_time,
      end_time: @end_time,
      name: params[:name],
      location: params[:location],
      description: params[:description],
    )
      render json: { status: "success", data: @subevent.as_json }
    else
      render json: { status: "failure", message: "Subevent not valid." }
    end
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by_id(params[:event_id])
    end

    def set_subevent
      @subevent = Subevent.find_by_id(params[:id])
    end

    def parse_dates
      @start_time = DateTime.parse(params[:start_time]) rescue nil
      @end_time = DateTime.parse(params[:end_time]) rescue nil
    end
end
