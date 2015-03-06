class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :channels
  has_many :users
end
