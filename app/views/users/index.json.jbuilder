json.array!(@users) do |user|
  json.extract! user, :id, :name, :last_name, :address_1, :address_2, :zip_code, :age, :email, :phone, :cellphone, :balance, :role_id, :country, :state, :city, :int_number, :ext_number, :username, :password
  json.url user_url(user, format: :json)
end
