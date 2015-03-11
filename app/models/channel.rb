class Channel < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users
  has_many :messages, -> { order 'id desc' }
end
