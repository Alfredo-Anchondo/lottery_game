class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :initial_balance
end
