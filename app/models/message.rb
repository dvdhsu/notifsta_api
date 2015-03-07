class Message < ActiveRecord::Base
  belongs_to :channel
  validates :message_guts, presence: true
  validates :channel, presence: true
end
