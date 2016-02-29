class GameSerializer < ActiveModel::Serializer
  attributes :team_id, :game_date, :description, :local_score, :visit_score, :team2_id
    has_one :team
    has_one :team2
    has_many :lotteries
    has_one :sport_category
end
