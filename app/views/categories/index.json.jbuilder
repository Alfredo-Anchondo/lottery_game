json.array!(@categories) do |category|
  json.extract! category, :id, :name, :description, :logo_file_name, :background_file_name
  json.url category_url(category, format: :json)
end
