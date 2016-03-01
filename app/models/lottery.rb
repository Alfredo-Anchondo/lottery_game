class Lottery < ActiveRecord::Base
  belongs_to :game
  before_update :update_winner, :if => :winner_number_changed? 
    
    
    def update_winner
        logger.info "ENTREEEEEEEEEEEEEEEEEE"
    end    
    
      def select_display
          game.team.name + " vs " + game.team2.name
      end
    
end
