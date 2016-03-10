class LotterySerializer < ActiveModel::Serializer
    attributes :id,:initial_balance, :rules, :description, :game_id, :winner_number, :initial_number, :final_number, :price
    
    has_one :team
    has_one :team2
end
