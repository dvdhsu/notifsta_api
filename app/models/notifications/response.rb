class Response < ActiveRecord::Base
  belongs_to :option
  belongs_to :user

  delegate :survey, to: :option

  validates :option, presence: true
  validates :user, presence: true
end
