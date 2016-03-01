class Lottery < ActiveRecord::Base
  belongs_to :game
  after_update :notify_systtem_if_winner_is_changed  
      def select_display
          game.team.name + " vs " + game.team2.name
      end

   
    
     
    
    def notify_systtem_if_winner_is_changed
        notify_system if previous_changes['winner_number'].any?
  end
    
end
