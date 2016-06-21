class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :initial_balance
  has_many :survivor_week_games
end
