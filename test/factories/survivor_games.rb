FactoryGirl.define do
  factory :survivor_game do
    factory :survivor_game_1 do
      association :survivor_week_game, :factory => :survivor_week_game_1
      handicap 2
      plus_handicap 2
      game_date "2016-06-16 12:00"
      association :team, :factory => :mavericks
      team2_id { Team.where(:name => "Celtics").first_or_create.id }
    end

    factory :survivor_game_2 do
      association :survivor_week_game, :factory => :survivor_week_game_1
      handicap 2
      plus_handicap 1
      game_date "2016-06-17 12:00"
      association :team, :factory => :mexico
      team2_id { Team.where(:name => "Germany").first_or_create.id }
    end

    factory :survivor_game_3 do
      association :survivor_week_game, :factory => :survivor_week_game_2
      handicap 1
      plus_handicap 1
      game_date "2016-10-07 12:00"
      association :team, :factory => :chicago
      team2_id { Team.where(:name => "Charlotte").first_or_create.id }
    end

    factory :survivor_game_4 do
      association :survivor_week_game, :factory => :survivor_week_game_2
      game_date "2016-10-08 12:00"
      association :team, :factory => :brazil
      team2_id { Team.where(:name => "Argentina").first_or_create.id }
    end
  end
end
