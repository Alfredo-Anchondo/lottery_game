class SurvivorWeekGame < ActiveRecord::Base
  belongs_to :survivor
	
	def select_display
		survivor.name + ' Semana ' + String(week)  
	end
	
	def self.get_games(id)
		SurvivorGame.where('survivor_week_game_id = ?', id)
	end
	

	
end
