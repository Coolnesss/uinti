json.array!(@event_users) do |event_user|
  json.extract! event_user, :id, :user_id, :event_id
  json.url event_user_url(event_user, format: :json)
end
