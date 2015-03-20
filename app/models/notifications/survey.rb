class Survey < Notification
  has_many :options, foreign_key: "notification_id", dependent: :destroy
  has_many :responses, through: :options
end
