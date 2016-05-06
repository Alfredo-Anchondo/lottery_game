json.array!(@quinielas) do |quiniela|
  json.extract! quiniela, :id
  json.url quiniela_url(quiniela, format: :json)
end
