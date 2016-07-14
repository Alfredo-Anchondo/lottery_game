class PickSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :initial_balance, :access_key, :users_quantity, :percentage
  has_one :user
end
