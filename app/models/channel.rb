class Channel < ActiveRecord::Base
  belongs_to :event
  has_many :messages, -> { order 'id desc' }
end
