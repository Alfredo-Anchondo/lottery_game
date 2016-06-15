class SurvivorUser < ActiveRecord::Base
  belongs_to :survivor_week_game
  belongs_to :team
  belongs_to :user
end
