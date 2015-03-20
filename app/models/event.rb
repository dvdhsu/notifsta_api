class Event < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :channels, dependent: :destroy

  validates :name, presence: true
end
