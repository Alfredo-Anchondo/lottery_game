json.array!(@survivors) do |survivor|
  json.extract! survivor, :id, :name, :description, :price, :initial_balance
  json.url survivor_url(survivor, format: :json)
end
