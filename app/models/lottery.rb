class Lottery < ActiveRecord::Base
  belongs_to :game
    
      def select_display
          game.team.name + " vs " + game.team2.name
      end
    
    
    def update_winner_number
        lottery.winner_number_changed?
    end    
end
