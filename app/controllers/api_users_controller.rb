class ApiUsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users.json
  def index
    @users = User.all
    render json: { status: "success", data: @users }
  end

  # GET /users/1.json
  def show
    if @user.nil?
      render json: { status: "failure", error: "couldn't find user" }
    else
      render json: { status: "success", data: @user.as_json(include: [:events, :channels]) }
    end
  end

  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
