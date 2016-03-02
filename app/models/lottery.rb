class Lottery < ActiveRecord::Base
  belongs_to :game
  before_update :update_winner, :if => :winner_number_changed? 
  has_many :user_lotteries 
    
    
    def update_winner
        lottery_name = game.team.name + " vs " + game.team2.name
        User.email_in_lottery(id, winner_number, lottery_name)
    end    
    
      def select_display
          game.team.name + " vs " + game.team2.name
      end
    
end
