class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validates_uniqueness_of :event_id, scope: :user_id
end
