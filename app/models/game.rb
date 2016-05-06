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
         numbers_array = []
        x = where('game_date = ?', DateTime.now.change(:sec => 0)).first 
        if x != nil && x != '' && x != []  
			
        y = Lottery.where('game_id = ?', x.id).first	
			if y
        z = User.where(:id => UserLottery.where('lottery_id = ?', y.id).pluck(:user_id).uniq).pluck(:email, :id)	
			end
			if z != nil && z != '' && z != []
         z.each do |variable|
            @repeat_number = []
        @tickets = UserLottery.where('user_id = ? AND lottery_id = ?' ,variable[1], y.id).pluck(:ticket_number)
            @tickets.each do |ticket|
               repeat = UserLottery.where('ticket_number = ? AND lottery_id = ?' ,ticket, y.id).count
               @repeat_number.push(repeat);
            end    
           
   			BuyMailer.close_lottery(x,y,z,@tickets,@repeat_number,variable[0]).deliver
		end
			 
	     q = Quiniela.where('game_id = ?', x.id).first
		if q
		 q_mails = User.where(:id => QuinielaUser.where('quiniela_id = ?', q.id).pluck(:user_id).uniq).pluck(:email, :id) 
		end
		if q_mails != nil && q_mails != '' && q_mails != []
		 	 q_mails.each do |variable|
				 @repeat_number_quiniela = []
				 @tickets = QuinielaUser.where('user_id = ? AND lottery_id = ?' ,variable[1], q.id).pluck(:ticket_number)
            @tickets.each do |ticket|
				 repeat = QuinielaUser.where('ticket_number = ? AND lottery_id = ?' ,ticket, q.id).count
				 @repeat_number_quiniela.push(repeat);
            end   
		 end
			  
				  BuyMailer.close_lottery_quiniela(x,y,z,@tickets,@repeat_number,variable[0]).deliver
		      end
			 
        end
        end
		
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
