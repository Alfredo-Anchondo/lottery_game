class QuinielaSerializer < ActiveModel::Serializer
	attributes :id, :initial_balance, :price, :description, :winner_number
	has_many :quiniela_questions
	has_one :game
	 has_one :team
    has_one :team2
end
