class User < ActiveRecord::Base
  require 'rest-client'
  require 'json'

  has_many :subscriptions, dependent: :destroy
  has_many :events, through: :subscriptions
  has_many :responses, dependent: :destroy

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Pagination
  paginates_per 100

  # Validations
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def check_facebook_token(token)
    if token.nil?
      # prevent the bad guys from passing in empty tokens
      false
    elsif (not self.facebook_token.nil?) and self.facebook_token == token
      # else, if I have a token, and it matches
      true
    else
      url = 'https://graph.facebook.com/debug_token?input_token=' +
        token + '&access_token=' + ENV['FACEBOOK_APP_ID'] +
        '|' + ENV['FACEBOOK_APP_SECRET']
      response = JSON.parse(RestClient.get url, accept: :json, content_type: :json)
      # token needs to be valid, and for the correct user
      (response['data']['is_valid'] and response['data']['user_id'] == self.facebook_id)
    end
  end

  def self.paged(page_number)
    order(admin: :desc, email: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("email LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, email: :asc
      ).page page_number
    else
      order(admin: :desc, email: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","email","last_sign_in_at")
  end

  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end
end
