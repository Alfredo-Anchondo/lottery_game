class Quiniela < ActiveRecord::Base
	belongs_to :game
	before_update :update_winner, :if => :winner_number_changed?

	has_many :quiniela_questions
 has_many :questions, :through => :quiniela_questions
    has_one :team, :through => :game
    has_one :team2, :through => :game
	has_attached_file :cap_result

    #Validations
	validates_attachment_content_type :cap_result, :content_type => /\Aimage\/.*\Z/

	accepts_nested_attributes_for :quiniela_questions, allow_destroy: true, reject_if: proc{ |attributes| attributes['question_id'].blank? }

	def total_sales
		QuinielaUser.where('quiniela_id = ?', id).length
	end


    def participant_users
		QuinielaUser.where('quiniela_id = ?', id).pluck(:user_id).uniq().count
	end


	def self.quiniela_game
		game.game_date
	end


	def winner?
		winner = QuinielaUser.where('quiniela_id = ? AND ticket_number = ?', id, winner_number)
		if winner != []
			return "Ganador"
			else
			return "Sin Ganador"
		end
	end

		def self.last_quinielas
			return  Quiniela.limit(10).order(id: :desc)
		end

	def self.find_no_winners
		ids = Array.new
		games_ids = Game.where('game_date >= ?', DateTime.now).pluck(:id)
		games_ids.each do |variable|
			ids.push(variable)
		end
		logger.info ids
		where(:game_id => ids )
	end



		def self.toclose
			where(:winner_number => '')
		end


	def update_winner
		quiniela_name = game.team.name + " vs " + game.team2.name
		User.email_in_quiniela(id, winner_number, quiniela_name)
		User.winner_quiniela_user(id, winner_number, quiniela_name, winner_number, initial_balance)
    end

	def questions_for_form
		collection = quiniela_questions.where(quiniela_id: id)
		collection.any? ? collection : quiniela_questions.build
    end

end
