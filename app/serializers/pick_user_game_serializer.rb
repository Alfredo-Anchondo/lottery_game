class PickUserGameSerializer < ActiveModel::Serializer
  attributes :id
  has_one :pick_user
  has_one :team
  has_one :survivor_game
end
