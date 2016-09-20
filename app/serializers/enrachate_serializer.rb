class EnrachateSerializer < ActiveModel::Serializer
  attributes :id, :price, :initial_balance, :percentage, :type, :description, :winner, :initial_date, :end_date
end
