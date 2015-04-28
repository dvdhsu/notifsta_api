class Subevent < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:start_time, "can't be before end_time")
    end
  end
end
