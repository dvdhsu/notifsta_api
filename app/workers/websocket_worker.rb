# app/workers/parse_push_worker.rb
class WebsocketWorker
  include Sidekiq::Worker

  def perform(notification_id)
    @notification = Notification.find(notification_id)
    @is_survey = @notification.is_a?(Survey)
    @options = @is_survey ? @notification.options.select(:id, :option_guts).to_a : nil

    data = {
      notification: {
        id: @notification.id,
        type: @notification.type,
        notification_guts: @notification.notification_guts,
        created_at: @notification.created_at,
        channel_id: @notification.channel.id,
        options: @options
      }
    }

    puts "Sending out websocket notification..."
    WebsocketRails["notifications_#{@notification.channel.event.name}".to_sym].trigger 'new', data
  end

end
