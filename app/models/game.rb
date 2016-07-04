class Game < ActiveRecord::Base
    belongs_to :team
    belongs_to :team2
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
			if y != nil && y != '' && y != []
        z = User.where(:id => UserLottery.where('lottery_id = ?', y.id).pluck(:user_id).uniq).pluck(:email, :id)
			end
			if z
         z.each do |variable|
            @repeat_number = []
        @tickets = UserLottery.where('user_id = ? AND lottery_id = ?' ,variable[1], y.id).pluck(:ticket_number)
            @tickets.each do |ticket|
               repeat = UserLottery.where('ticket_number = ? AND lottery_id = ?' ,ticket, y.id).count
               @repeat_number.push(repeat);
            end

   		BuyMailer.close_lottery(x,y,z,@tickets,@repeat_number,variable[0]).deliver
		end
	end

	     q = Quiniela.where('game_id = ?', x.id)
		if q != nil && q != '' && q != []
			q.each do |tira|
				 q_mails = User.where(:id => QuinielaUser.where('quiniela_id = ?', tira.id).pluck(:user_id).uniq).pluck(:email, :id)
	
		if q_mails
		 	 q_mails.each do |variable|
				 @repeat_number_quiniela = []
				 @tickets = QuinielaUser.where('user_id = ? AND quiniela_id = ?' ,variable[1], tira.id).pluck(:ticket_number)
            @tickets.each do |ticket|
				 repeat = QuinielaUser.where('ticket_number = ? AND quiniela_id = ?' ,ticket, tira.id).count
				 @repeat_number_quiniela.push(repeat);
            end
			BuyMailer.close_lottery_quiniela(x,tira,q_mails,@tickets,@repeat_number_quiniela,variable[0]).deliver
		 end
	end

		      end
			end
		
        end

    end


    def self.next_game
        where('game_date >= ?', DateTime.now).order(:game_date).limit(5)
    end



    def self.future_games
        where('game_date >= ?', DateTime.now).order(:game_date).all
    end

    def self.future_games_programed
		future_games = []
		total_sales = 0
       games_id = where('game_date >= ?', DateTime.now).order(:game_date)
		games_id.each do|game|
		lotteries =  Lottery.find_by game_id: game.id
		quinielas = Quiniela.find_by game_id: game.id
			if lotteries
				tickets_sale_lot = UserLottery.where(lottery_id: lotteries.id)
				if tickets_sale_lot
					tickets_sale_lot = tickets_sale_lot.count
					money_sales_lot = tickets_sale_lot * Integer(lotteries.price)
					else
					tickets_sale_lot = 0
				end
				total_sales += money_sales_lot
				future_games.push({date: game.game_date.strftime('%d-%m-%Y %H:%M'), category: game.category.name, event: game.team.name + ' vs ' + game.team2.name, type: 'Loteria', sales: tickets_sale_lot, money: money_sales_lot })
			end
			if quinielas
			  tickets_sale = QuinielaUser.where(quiniela_id: quinielas.id)
				if tickets_sale
					tickets_sale = tickets_sale.count
					money_sales = tickets_sale * Integer(quinielas.price)
					else
					tickets_sale = 0
				end
				total_sales += money_sales
				future_games.push({date: game.game_date.strftime('%d-%m-%Y %H:%M'), category: game.category.name, event: quinielas.description, type: 'Tira', sales: tickets_sale, money: money_sales })
			end
		end
		return ({ data: future_games, total_sales: total_sales})
    end

      def self.finish_games
          where('game_date <= ?', DateTime.now).order(game_date: :desc).first(50)
    end

    def self.today_games
		loterias = Lottery.where('winner_number IS NULL').pluck(:game_id)
		logger.info loterias
		games = Game.find(loterias)
		return games
    end

end
