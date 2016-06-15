json.array!(@survivor_week_games) do |survivor_week_game|
  json.extract! survivor_week_game, :id, :survivor_id, :initial_date, :final_date, :week
  json.url survivor_week_game_url(survivor_week_game, format: :json)
end
