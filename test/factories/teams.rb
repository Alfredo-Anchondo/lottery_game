FactoryGirl.define do
  factory :team do
    initialize_with { Team.where(:name => name, :sport_category => sport_category).first_or_create }

    factory :mavericks do
      name "Mavericks"
      association :sport_category, :factory => :basketball_nba
    end

    factory :chicago do
      name "Chicago"
      association :sport_category, :factory => :basketball_nba
    end

    factory :mexico do
      name "Mexico"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :brazil do
      name "Brazil"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :celtics do
      name "Celtics"
      association :sport_category, :factory => :basketball_nba
    end

    factory :charlotte do
      name "Charlotte"
      association :sport_category, :factory => :basketball_nba
    end

    factory :germany do
      name "Germany"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :argentina do
      name "Argentina"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :rockets do
      name "Rockets"
      association :sport_category, :factory => :basketball_nba
    end

    factory :lackers do
      name "Lackers"
      association :sport_category, :factory => :basketball_nba
    end

    factory :italy do
      name "Italy"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :france do
      name "France"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :nuggets do
      name "Nuggets"
      association :sport_category, :factory => :basketball_nba
    end

    factory :clippers do
      name "Clippers"
      association :sport_category, :factory => :basketball_nba
    end

    factory :usa do
      name "USA"
      association :sport_category, :factory => :soccer_fifa
    end

    factory :neerland do
      name "Neerland"
      association :sport_category, :factory => :soccer_fifa
    end
  end
end
