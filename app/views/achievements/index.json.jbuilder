json.array!(@achievements) do |achievement|
  json.extract! achievement, :id, :poke_id, :title
  json.url achievement_url(achievement, format: :json)
end
