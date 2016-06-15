json.array!(@survivor_users) do |survivor_user|
  json.extract! survivor_user, :id, :survivor_week_game_id, :team_id, :purchase_date, :user_id, :status
  json.url survivor_user_url(survivor_user, format: :json)
end
