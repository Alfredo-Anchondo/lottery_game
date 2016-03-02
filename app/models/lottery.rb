class Lottery < ActiveRecord::Base
  belongs_to :game
  before_update :update_winner, :if => :winner_number_changed? 
  has_many :user_lotteries 
    
    
    def update_winner
        logger.info "ENTREEEEEEEEEEEEEEEEEE"
        logger.info game.user_lotteries
    end    
    
      def select_display
          game.team.name + " vs " + game.team2.name
      end
    
end
