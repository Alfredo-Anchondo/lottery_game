class EnrachateSerializer < ActiveModel::Serializer
  attributes :id, :price, :initial_balance, :percentage, :type_enrachate, :description, :winner, :initial_date, :end_date
  has_many :relation_enrachate_tiras

    
end
