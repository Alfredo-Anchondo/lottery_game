class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :initial_balance, :user_id, :participant_users, :user_username, :background_url, :percentage, :rebuy_quantity, :access_key, :user_quantity	
  has_many :survivor_week_survivors
end
