class GameSerializer < ActiveModel::Serializer
    attributes :id ,:team_id, :game_date, :description, :local_score, :visit_score, :team2_id, :lottery
    has_one :team
    has_one :team2
    has_many :lotteries
    has_one :sport_category
    has_one :category
end
