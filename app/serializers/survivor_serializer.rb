class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :initial_balance, :user_id, :participant_users
  has_many :survivor_week_survivors
	
end
