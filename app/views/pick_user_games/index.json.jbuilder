json.array!(@pick_user_games) do |pick_user_game|
  json.extract! pick_user_game, :id, :pick_user_id, :team_id, :survivor_game_id
  json.url pick_user_game_url(pick_user_game, format: :json)
end
