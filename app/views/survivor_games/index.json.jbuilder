json.array!(@survivor_games) do |survivor_game|
  json.extract! survivor_game, :id, :team_id, :team2_id, :handicap, :plus_handicap, :description, :game_date, :winner_team, :survivor_week_game_id
  json.url survivor_game_url(survivor_game, format: :json)
end
