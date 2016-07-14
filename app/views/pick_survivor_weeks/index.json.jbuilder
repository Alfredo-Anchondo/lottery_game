json.array!(@pick_survivor_weeks) do |pick_survivor_week|
  json.extract! pick_survivor_week, :id, :pick_id, :survivor_week_game_id
  json.url pick_survivor_week_url(pick_survivor_week, format: :json)
end
