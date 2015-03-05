json.array!(@channels) do |channel|
  json.extract! channel, :id
  json.url channel_url(channel, format: :json)
end
