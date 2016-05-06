json.array!(@quiniela_users) do |quiniela_user|
  json.extract! quiniela_user, :id
  json.url quiniela_user_url(quiniela_user, format: :json)
end
