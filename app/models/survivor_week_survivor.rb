class SurvivorWeekSurvivor < ActiveRecord::Base
  belongs_to :survivor
  belongs_to :survivor_week_game
end
