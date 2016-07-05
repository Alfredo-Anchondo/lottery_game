class SurvivorGameSerializer < ActiveModel::Serializer
  attributes :id, :handicap, :plus_handicap, :description, :game_date, :winner_team, :local_score, :visit_score, :past_game
  has_one :team
  has_one :team2
end
