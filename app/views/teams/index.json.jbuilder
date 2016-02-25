json.array!(@teams) do |team|
  json.extract! team, :id, :name, :description, :sport_category_id, :logo

end
