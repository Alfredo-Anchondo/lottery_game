class LotterySerializer < ActiveModel::Serializer

    attributes :id,:initial_balance, :rules, :description, :game2_id, :game_id, :winner_number, :initial_number, :final_number, :price, :purchase_gift_tickets, :total_sales, :to_mainpage


    has_one :game2
    has_one :team, :through => :game2
    has_one :team2, :through => :game2
    has_one :team
    has_one :team2
end
