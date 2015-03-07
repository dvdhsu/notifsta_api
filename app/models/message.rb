class Message < ActiveRecord::Base
  belongs_to :channel

  validates :message_guts, presence: true
  validates :channel, presence: true

  after_save :parse_push_notify
  after_save :roost_push_notify

  private
    def parse_push_notify
      ParsePushWorker.perform_async self.id
    end

    def roost_push_notify
      RoostPushWorker.perform_async self.id
    end

end
