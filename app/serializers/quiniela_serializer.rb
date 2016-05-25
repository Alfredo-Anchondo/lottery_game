class QuinielaSerializer < ActiveModel::Serializer
	attributes :id, :initial_balance, :price, :description, :winner_number, :purchase_gift_tickets,:total_sales
	has_many :quiniela_questions
	has_one :game
	has_one :team
    has_one :team2
end
