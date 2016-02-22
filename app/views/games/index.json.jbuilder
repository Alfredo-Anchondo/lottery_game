json.array!(@games) do |game|
  json.extract! game, :id, :team_id, :game_date, :description, :local_score, :visit_score, :team2_id
  json.url game_url(game, format: :json)
end
