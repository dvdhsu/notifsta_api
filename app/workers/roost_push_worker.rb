# app/workers/parse_push_worker.rb
class RoostPushWorker
  include Sidekiq::Worker

  def perform(message_id)
    @message = Message.find(message_id)
    data = {
      alert: @message.message_guts,
      url: "http://notifsta.com/webclient"
    }
    puts "Sending Roost push notification..."
    puts data
    Roost::API.send data
  end

end
