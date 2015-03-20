class Option < ActiveRecord::Base
  belongs_to :survey, foreign_key: "notification_id"
  has_many :responses
end
