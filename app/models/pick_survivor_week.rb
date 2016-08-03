class PickSurvivorWeek < ActiveRecord::Base
  belongs_to :pick
  belongs_to :survivor_week_game
  has_many :pick_users	
end

def select_display
     "#{pick.name} / #{survivor_week_game.select_display}"
end