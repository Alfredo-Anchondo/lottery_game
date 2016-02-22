json.array!(@roles) do |role|
  json.extract! role, :id, :name, :description, :is_admin, :is_client
  json.url role_url(role, format: :json)
end
