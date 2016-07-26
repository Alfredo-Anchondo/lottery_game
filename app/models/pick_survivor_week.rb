class PickSurvivorWeek < ActiveRecord::Base
  belongs_to :pick
  belongs_to :survivor_week_game
  has_many :pick_users	
end
