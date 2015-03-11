# app/workers/parse_push_worker.rb
class WebsocketWorker
  include Sidekiq::Worker

  def perform(message_id)
    @message = Message.find(message_id)
    data = {
      message: {
        message_guts: @message.message_guts,
        created_at: @message.created_at
      },
      channel_id: @message.channel.id
    }
    puts "messages_#{@message.channel.event.name}"
    WebsocketRails["messages_#{@message.channel.event.name}".to_sym].trigger 'new', data
  end

end
