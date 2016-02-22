json.array!(@sport_categories) do |sport_category|
  json.extract! sport_category, :id, :sport_id, :category_id
  json.url sport_category_url(sport_category, format: :json)
end
