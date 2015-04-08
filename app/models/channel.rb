class Channel < ActiveRecord::Base
  belongs_to :event, touch: true
  has_many :notifications, -> { order 'id desc' }, dependent: :destroy

  validates :event, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :event_id
end
