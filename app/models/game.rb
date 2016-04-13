class Game < ActiveRecord::Base
    belongs_to :team
    belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
    has_many :lotteries
    has_one :sport_category, through: :team
    has_one :category, through: :sport_category
    
    def select_display
         team.name + " vs " + team2.name
    end
    
    def format_date
        game_date.strftime("%e-%m-%Y %l:%M %p")
    end
    
    def self.close_lottery_buy
        x = where(game_date: (DateTime.now.change(:sec => 0))..(DateTime.now.change(:sec => 0) + 59.seconds)).order(:game_date).first  
        
        Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
        
        logger.info "%$#%$##%$#%$#%$ Ya corrio el proceso $@$@#!@$" 
        logger.info x
        logger.info DateTime.now.change(:sec => 0)
    end
    
    
    def self.next_game
        where('game_date >= ?', DateTime.now).order(:game_date).first 
    end
    
    def self.future_games
        where('game_date >= ?', DateTime.now).order(:game_date).all
    end
    
      def self.finish_games
          where('game_date <= ?', DateTime.now).order(game_date: :desc).all
    end
    
    def self.today_games
        where('game_date >= ? AND game_date < ?', DateTime.now - 1, DateTime.now.tomorrow ).order(game_date: :desc).all
    end
    
end
