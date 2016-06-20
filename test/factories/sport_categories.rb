FactoryGirl.define do
  factory :sport_category do
    initialize_with { SportCategory.where(:sport => sport, :category => category).first_or_create }

    factory :basketball_nba do
      association :sport, :factory => :basketball
      association :category, :factory => :nba
    end

    factory :soccer_fifa do
      association :sport, :factory => :soccer
      association :category, :factory => :fifa
    end
  end
end
