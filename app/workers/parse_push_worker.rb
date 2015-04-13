# app/workers/parse_push_worker.rb
class ParsePushWorker
  include Sidekiq::Worker
  require 'parse-ruby-client' 

  def perform(notification_id)
    Parse.init(application_id: ENV["PARSE_APPLICATION_ID"], api_key: ENV["PARSE_REST_API_KEY"], quiet: false)
    @notification = Notification.find(notification_id)
    data = {
      alert: @notification.notification_guts ,
      # TODO: this needs to be changed to event.id
      event: @notification.channel.event.name,
      # TODO: this needs to be changed to channel.id
      channel: @notification.channel.name
    }
    # TODO: this needs to be changed to channel.id
    push = Parse::Push.new(data, @notification.channel.guid)
    puts "Sending Parse push notification..."
    push.save
  end

end
