class ApiResponsesController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_response, only: [:show]

  def index
    @survey = Survey.find_by_id(params[:notification_id])
    sub = current_user.subscriptions.where(event_id: @survey.channel.event.id).first

    # if the Survey isn't found, the sub doesn't exist, or the user isn't
    # admin (user must be admin to list all responses)...
    if @survey.nil?  || sub.nil? || (not sub.admin)
      render json: { status: "failure", error: "Survey not found, or unauthorized." }
    else
      @responses = @survey.responses
      render "responses/index"
    end
  end

  def show
    # if the response is nil, or I'm not subscribed to the event, or
    # it both (doesn't belong to me AND I'm not an admin), then deny access...

    # TODO: remove needless sub.nil? check. It's only needed to guard against
    # sub.admin failing...
    sub = current_user.subscriptions.where(event_id: @response.survey.channel.event.id).first
    if @response.nil? || sub.nil? || (@response.user_id != current_user.id && (not sub.admin))
      render json: { status: "failure", error: "Response not found, or unauthorized." }
    else
      render "responses/show"
    end
  end

  def create
    @survey = Survey.find_by_id(params[:notification_id])
    sub = current_user.subscriptions.where(event_id: @survey.channel.event.id).first

    # if the survey doesn't exist, or I'm not authorized to answer it...
    if @survey.nil? || sub.nil?
      render json: { status: "failure", error: "Survey not found, or unauthorized." }
    # TODO: DRY this
    elsif @survey.options.find_by_id(params[:option_id]).nil?
      render json: { status: "failure", error: "Option is wrong." }
    else
      # if this is non-empty, we'll delete them once we save the current
      # response
      @response = current_user.responses.new(option_id: (params[:option_id]))
      if @response.valid?
        # inefficient -- fix this
        @survey.responses.where(user_id: current_user.id).destroy_all
        @response.save!
        render "responses/show"
      else
        render json: { status: "failure", data: @response.errors }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option_id)
    end
end
