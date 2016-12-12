class GiftCardSerializer < ActiveModel::Serializer
  attributes :id, :value, :code, :available
  has_one :user
end
