class Channel < ActiveRecord::Base
  belongs_to :event
  has_many :notifications, -> { order 'id desc' }
end
