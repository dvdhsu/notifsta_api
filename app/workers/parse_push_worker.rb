# app/workers/parse_push_worker.rb
class ParsePushWorker
  include Sidekiq::Worker
  require 'parse-ruby-client' 

  def perform(message_id)
    Parse.init(application_id: ENV["PARSE_APPLICATION_ID"], api_key: ENV["PARSE_REST_API_KEY"], quiet: false)
    @message = Message.find(message_id)
    puts @message.channel.event.name
    puts @message.channel.name
    data = {
      alert: @message.message_guts ,
      # TODO: this needs to be changed to event.id
      event: @message.channel.event.name,
      # TODO: this needs to be changed to channel.id
      channel: @message.channel.name
    }
    # TODO: this needs to be changed to channel.id
    push = Parse::Push.new(data, @message.channel.name)
    push.save
  end

end
