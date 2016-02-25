class Lottery < ActiveRecord::Base
  belongs_to :game
    
      def select_display
          game.team.name + " vs " + game.team2.name
    end
    
    def self.day_lottery()
        where('game_id >= ?', params[:game_id])
    end
end
