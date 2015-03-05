class Event < ActiveRecord::Base
  has_many :channels
  has_many :users
end
