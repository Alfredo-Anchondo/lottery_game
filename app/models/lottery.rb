class Lottery < ActiveRecord::Base
  belongs_to :game
    
      def select_display
          game.team.name + " vs " + game.team2.name
    end
end
