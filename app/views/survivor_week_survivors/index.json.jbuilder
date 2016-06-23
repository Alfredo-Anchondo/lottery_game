json.array!(@survivor_week_survivors) do |survivor_week_survivor|
  json.extract! survivor_week_survivor, :id, :survivor_id_id, :survivor_week_games_id_id
  json.url survivor_week_survivor_url(survivor_week_survivor, format: :json)
end
