object @notification

attributes :id, :channel_id, :notification_guts, :type, :created_at

node(:options, if: locals[:is_survey]) do |survey|
  survey.options.map do |option|
    partial("notifications/option", object: option)
  end
end

node(:response, if: locals[:is_survey]) do |survey|
  response = survey.responses.where(user_id: current_user.id).first rescue nil
  # if they've responded...
  if (not response.nil?)
    partial("notifications/response", object: response)
  end
end
