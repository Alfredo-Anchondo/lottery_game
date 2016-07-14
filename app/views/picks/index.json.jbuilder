json.array!(@picks) do |pick|
  json.extract! pick, :id, :name, :description, :user_id, :price, :initial_balance, :access_key, :users_quantity, :percentage
  json.url pick_url(pick, format: :json)
end
