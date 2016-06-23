class SurvivorWeekSurvivorSerializer < ActiveModel::Serializer
  attributes :id
  has_one :survivor_week_game
end
