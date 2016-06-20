FactoryGirl.define do
  factory :user do
    initialize_with do
      User.where(:email => email).first_or_create
    end

    factory :aanchondo do
      name "Alfredo"
      last_name "Anchondo"
      address_1 "calle"
      address_2 "lugar"
      zip_code "1234"
      email "alfre@sad.com"
      cellphone "478324"
      association :role, :factory => :client
      country "mexico"
      username "aanchondo"
      password "aanchondo"
      password_confirmation "aanchondo"
    end

    factory :jluna do
      name "Jorge"
      last_name "Luna"
      address_1 "calle"
      address_2 "lugar"
      zip_code "5678"
      email "jluna@publiwi.com"
      cellphone "5573941543"
      association :role, :factory => :client
      country "mexico"
      username "jluna"
      password "jluna123"
      password_confirmation "jluna123"
    end
  end
end
