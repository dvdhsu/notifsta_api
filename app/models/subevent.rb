class Subevent < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
