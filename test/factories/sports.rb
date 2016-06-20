FactoryGirl.define do
  factory :sport do
    initialize_with { Sport.where(:name => name).first_or_create }

    factory :basketball do
      name "Basketball"
    end

    factory :soccer do
      name "Soccer"
    end
  end
end
