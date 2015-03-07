class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :webclient
  ]

  def home
  end

  def webclient
  end
  
  
end
