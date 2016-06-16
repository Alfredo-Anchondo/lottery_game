class SurvivorGame < ActiveRecord::Base
  #ASSOCIATIONS
  belongs_to :team
  belongs_to :team2
  belongs_to :survivor_week_game

  #VALIDATIONS
  validate :team_id, :team2_id, :survivor_week_game_id, :game_date, :presence => true

  #METHODS
	def second_team
		Team.find(team2_id)
	end
end
