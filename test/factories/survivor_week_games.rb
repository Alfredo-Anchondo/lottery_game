FactoryGirl.define do
  factory :survivor_week_game do
    initialize_with { SurvivorWeekGame.where(:survivor => survivor, :initial_date => initial_date, :final_date => final_date, :week => week).first_or_create }

    factory :survivor_week_game_1 do
      initial_date "2016-06-16"
      final_date "2016-06-22"
      week 1
      survivor
    end

    factory :survivor_week_game_2 do
      initial_date "2016-10-07"
      final_date "2016-10-13"
      week 17
      survivor
    end

    factory :survivor_week_game_3 do
      initial_date "2016-10-15"
      final_date "2016-10-21"
      week 1
      association :survivor, :factory => :survivor_from_aanchondo
    end

    factory :survivor_week_game_4 do
      initial_date "2016-10-22"
      final_date "2016-10-28"
      week 17
      association :survivor, :factory => :survivor_from_aanchondo
    end
  end
end
