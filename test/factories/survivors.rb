FactoryGirl.define do
  factory :survivor do
    initialize_with { Survivor.where(:name => name).first_or_create }
    name "Survivor"
    price "100"
    initial_balance "2000"

    factory :survivor_from_aanchondo do
      name "Survivor from aanchondo"
      price "100"
      initial_balance "4000"
      percentage 20
      association :user, :factory => :aanchondo
    end
  end
end
