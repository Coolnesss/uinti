json.array!(@events) do |event|
  json.extract! event, :id, :time, :place
  json.url event_url(event, format: :json)
end
