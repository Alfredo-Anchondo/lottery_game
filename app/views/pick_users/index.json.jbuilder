json.array!(@pick_users) do |pick_user|
  json.extract! pick_user, :id, :user_id, :pick_survivor_week_id, :points, :local_score, :visit_score, :pick_user_id
  json.url pick_user_url(pick_user, format: :json)
end
