class Game < ActiveRecord::Base
    belongs_to :team
    belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
    has_many :lotteries
    has_one :sport_category, through: :team  
    
      def select_display
         team.name + " vs " + team2.name
    end
    
    def self.next_game
        where('game_date >= ?', DateTime.now).order(:game_date).first 
    end
    
    def self.future_games
        where('game_date >= ?', DateTime.now).order(:game_date).all
    end
    
end
