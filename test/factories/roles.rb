FactoryGirl.define do
  factory :role do
    factory :client do
      name "Client"
      is_client true
    end
  end
end
