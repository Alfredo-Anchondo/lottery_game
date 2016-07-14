class PickSurvivorWeekSerializer < ActiveModel::Serializer
  attributes :id
  has_one :pick
  has_one :survivor_week_game
end
