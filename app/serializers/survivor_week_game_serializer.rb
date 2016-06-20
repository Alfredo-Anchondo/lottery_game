class SurvivorWeekGameSerializer < ActiveModel::Serializer
  attributes :id, :initial_date, :final_date, :week
	has_many :survivor_games
end
