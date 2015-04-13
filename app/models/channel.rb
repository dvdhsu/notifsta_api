class Channel < ActiveRecord::Base
  belongs_to :event, touch: true
  has_many :notifications, -> { order 'id desc' }, dependent: :destroy

  validates :event, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :event_id

  before_save :generate_guid

  def generate_guid
    self.guid = 'c' + SecureRandom.uuid
  end
end
