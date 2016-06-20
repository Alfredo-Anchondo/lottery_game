FactoryGirl.define do
  factory :category do
    initialize_with { Category.where(:name => name).first_or_create }

    factory :nba do
      name "NBA"
    end

    factory :fifa do
      name "FIFA"
    end
  end
end
