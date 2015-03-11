class Message < ActiveRecord::Base
  belongs_to :channel

  validates :message_guts, presence: true
  validates :channel, presence: true

  after_commit :parse_push_notify
  after_commit :roost_push_notify
  after_commit :websocket_notify

  private
    def parse_push_notify
      ParsePushWorker.perform_async self.id
    end

    def roost_push_notify
      RoostPushWorker.perform_async self.id
    end

    def websocket_notify
      WebsocketWorker.perform_async self.id
    end

end
