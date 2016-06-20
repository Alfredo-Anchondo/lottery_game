FactoryGirl.define do
  factory :survivor do
    initialize_with { Survivor.where(:name => name).first_or_create }
    name "Survivor"
    price "100"
    initial_balance "2000"
  end
end
