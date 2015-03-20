class Notification < ActiveRecord::Base
  belongs_to :channel

  validates :notification_guts, presence: true
  validates :type, presence: true
  validates :channel, presence: true

  after_commit :parse_push_notify
  after_commit :roost_push_notify
  after_commit :websocket_notify

  def as_json(options = {})

  # since `type' isn't returned, we have to include it with an `only' when we
  # convert to JSON. Annoying, but there are no better workarounds.
  # https://github.com/rails/rails/issues/3508

    super(options.merge(only: [:channel_id, :id, :notification_guts, :created_at, :updated_at, :type]))
  end

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
