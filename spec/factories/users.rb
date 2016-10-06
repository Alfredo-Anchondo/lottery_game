FactoryGirl.define do
  factory :user do
    name          { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.email }
    phone         { Faker::PhoneNumber.phone_number }
    cellphone     { Faker::PhoneNumber.cell_phone}
    address_1     { Faker::Address.street_address }
    address_2     { Faker::Address.secondary_address }
    zip_code      { Faker::Address.zip }
    age           { Faker::Number.between(18, 99)}
    balance       { Faker::Number.between(0, 1000)}
    role_id       { 2 }
    country       { Faker::Address.country }
    state         { Faker::Address.state }
    city          { Faker::Address.city }
    int_number    { Faker::Address.building_number }
    username      { Faker::Internet.user_name }
    ext_number    { Faker::Address.building_number }
    password      { Faker::Internet.password }
    birthday      { Faker::Date.between(50.years.ago, 20.years.ago) }
    gender        { Faker::Pokemon.name }
    openpay_id    { Faker::Lorem.characters(10) }
    gift_credit   { Faker::Number.between(0, 1000)}    
  end
end
