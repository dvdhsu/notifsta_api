class ApiAuthenticationController < ApplicationController

  before_action :authenticate_user!, only: [
    :get_authentication_token
  ]

  def login
    @user = User.where(email: params[:email]).first
    if not @user.nil? and @user.valid_password?(params[:password])
      render json: { status: "success", data: @user }
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
  
  def get_authentication_token
    render json: { status: "success", data: { authentication_token: current_user.authentication_token } }
  end
end
