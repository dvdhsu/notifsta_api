class Option < ActiveRecord::Base
  belongs_to :survey, foreign_key: "notification_id"
  has_many :responses, dependent: :destroy

  delegate :event, to: :survey

  validates :survey, presence: true
  validates :option_guts, presence: true
  validates_uniqueness_of :option_guts, scope: :notification_id
end
