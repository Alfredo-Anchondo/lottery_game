class UserLotterySerializer < ActiveModel::Serializer
    attributes :id, :user_id, :lottery_id, :status, :ticket_number, :purchase_date
    
    has_one :user
    has_one :lottery
end
