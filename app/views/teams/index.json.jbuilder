json.array!(@teams) do |team|
  json.extract! team, :id, :name, :description, :sport_category_id
  json.url team_url(team, format: :json)
end
