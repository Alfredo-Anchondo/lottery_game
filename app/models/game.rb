class Game < ActiveRecord::Base
    belongs_to :team
    belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
    
      def select_display
         team.name + " vs " + team2.name
    end
    
end
