json.array!(@enrachates) do |enrachate|
  json.extract! enrachate, :id, :price, :initial_balance, :percentage, :type, :description, :winner, :initial_date, :end_date
  json.url enrachate_url(enrachate, format: :json)
end
