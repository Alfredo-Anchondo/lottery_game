class Quiniela < ActiveRecord::Base
	belongs_to :game
	before_update :update_winner, :if => :winner_number_changed? 
	has_many :quiniela_questions
    has_one :team, :through => :game
    has_one :team2, :through => :game
	accepts_nested_attributes_for :quiniela_questions, allow_destroy: true, reject_if: proc{ |attributes| attributes['question_id'].blank? }
		
	
		def self.find_no_winners
			where('winner_number' => '')
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
