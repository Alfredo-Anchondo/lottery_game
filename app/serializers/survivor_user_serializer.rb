class SurvivorUserSerializer < ActiveModel::Serializer
  attributes :id, :purchase_date, :status, :survivor_user_id
  has_one :survivor_week_survivor
  has_one :team
  has_one :user	
end
