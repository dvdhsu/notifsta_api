class Event < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :channels, dependent: :destroy
  has_many :subevents, -> { order 'start_time' }, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time

  geocoded_by :address
  after_validation :geocode

  def admins
    self.subscriptions.where(admin: true)
  end

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:start_time, "can't be before end_time")
    end
  end
end
