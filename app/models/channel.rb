class Channel < ActiveRecord::Base
  belongs_to :event
  has_many :users
  has_many :messages
end
