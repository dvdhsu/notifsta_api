class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :webclient
  ]

  def home
  end

  def event_admin
  end

  def webclient
    event = current_user.events.first
    channel_array = event.channels.as_json(include: {
      messages: {
        only: [:message_guts, :created_at]
      }
    },
    only: [:name, :id])

    @event_name = event.name
    # http://stackoverflow.com/questions/4753930/convert-array-of-hashes-to-a-hash-of-hashes-indexed-by-an-attribute-of-the-hash
    @initial_channel_hash = channel_array.map { |r| ["_" + r["id"].to_s, r] }.to_h
  end
  
  
end
