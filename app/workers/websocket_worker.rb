# app/workers/parse_push_worker.rb
class WebsocketWorker
  include Sidekiq::Worker

  def perform(notification_id)
    @notification = Notification.find(notification_id)
    data = {
      notification: {
        notification_guts: @notification.notification_guts,
        created_at: @notification.created_at
      },
      channel_id: @notification.channel.id
    }
    puts "notifications_#{@notification.channel.event.name}"
    WebsocketRails["notifications_#{@notification.channel.event.name}".to_sym].trigger 'new', data
  end

end
