# app/workers/parse_push_worker.rb
class RoostPushWorker
  include Sidekiq::Worker

  def perform(notification_id)
    @notification = Notification.find(notification_id)
    data = {
      alert: @notification.notification_guts,
      url: "http://notifsta.com/webclient"
    }
    puts "Sending Roost push notification..."
    puts data
    Roost::API.send data
  end

end
