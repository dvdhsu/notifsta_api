class Event < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :channels, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  geocoded_by :address
  after_validation :geocode

  def admins
    self.subscriptions.where(admin: true)
  end
end
