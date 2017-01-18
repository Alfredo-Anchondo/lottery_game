class Lottery < ActiveRecord::Base
  belongs_to :game

belongs_to :game2, :foreign_key => :game2_id
before_update :update_winner, :if => :winner_number_changed?
has_many :user_lotteries
has_one :team, :through => :game
has_one :team2, :through => :game
has_one :team, :through => :game2
has_one :team2, :through => :game2


    def update_winner
        lottery_name = game.team.name + " vs " + game.team2.name
        User.email_in_lottery(id, winner_number, lottery_name)
        User.winner_user(id, winner_number, lottery_name, winner_number, initial_balance)
    end

	def winner?
		winner = UserLottery.where('lottery_id = ? AND ticket_number = ?', id, String(winner_number))
		if winner != []
			return "Ganador"
			else
			return "Sin Ganador"
		end
	end

	def self.last_lotteries
		return Lottery.limit(10).order(id: :desc)

		end

      def select_display
          game.team.name + " vs " + game.team2.name
      end

	def total_sales
		UserLottery.where('lottery_id = ?', id).length
	end

    def participant_users
        UserLottery.where('lottery_id = ?', id).pluck(:user_id).uniq().count
    end
end
