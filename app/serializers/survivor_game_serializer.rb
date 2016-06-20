class SurvivorGameSerializer < ActiveModel::Serializer
  attributes :id, :handicap, :plus_handicap, :description, :game_date, :winner_team
  has_one :team
  has_one :team2
  has_one :survivor_week_game
end
