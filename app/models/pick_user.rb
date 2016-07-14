class PickUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :pick_survivor_week
  belongs_to :pick_user
	
  after_create :update_survivor_user_id	
	
	def update_survivor_user_id
		if pick_user_id.blank?
			update({pick_user_id: id})
		end
	end
	
end
