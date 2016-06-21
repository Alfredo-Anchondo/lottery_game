FactoryGirl.define do
  factory :survivor_user do
    status "bought"

    factory :survivor_user_1 do
      association :survivor_week_game, :factory => :survivor_week_game_1
      association :team, :factory => :mavericks
      association :user, :factory => :aanchondo
      purchase_date { survivor_week_game.initial_date }
    end

    factory :survivor_user_2 do
      association :survivor_week_game, :factory => :survivor_week_game_1
      association :team, :factory => :celtics
      association :user, :factory => :jluna
      purchase_date { survivor_week_game.initial_date }
    end

    factory :survivor_user_3 do
      association :survivor_week_game, :factory => :survivor_week_game_1
      association :team, :factory => :mexico
      association :user, :factory => :jluna
      purchase_date { survivor_week_game.initial_date }
    end

    factory :survivor_user_4 do
      association :survivor_week_game, :factory => :survivor_week_game_2
      association :team, :factory => :charlotte
      association :user, :factory => :aanchondo
      purchase_date { survivor_week_game.initial_date }
    end

    factory :survivor_user_5 do
      association :survivor_week_game, :factory => :survivor_week_game_2
      association :team, :factory => :charlotte
      association :user, :factory => :jluna
      purchase_date { survivor_week_game.initial_date }
    end

    factory :survivor_user_6 do
      association :survivor_week_game, :factory => :survivor_week_game_2
      association :team, :factory => :brazil
      association :user, :factory => :jluna
      purchase_date { survivor_week_game.initial_date }
    end
  end
end
