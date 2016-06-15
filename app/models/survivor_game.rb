class SurvivorGame < ActiveRecord::Base
  belongs_to :team
  belongs_to :team2
  belongs_to :survivor_week_game
	
	def second_team
		Team.find(team2_id)
	end
end
