class SurvivorUser < ActiveRecord::Base
  #SCOPE
  scope :bought, -> { where(:status => "bought") }
  scope :loser, -> { where(:status => "loser") }
  scope :alive, -> { where(:status => "alive") }
  scope :winner, -> { where(:status => "winner") }

  #ASSOCIATIONS
  belongs_to :survivor_week_survivor
  belongs_to :team
  belongs_to :user
  belongs_to :survivor_user

  #VALIDATIONS
  validates :survivor_week_survivor_id, :user_id, :presence => true
  validate :available_rebuy, :on => :create
  validate :available_team, :on => :create
  validate :available_entrys, :on => :create	

  #CALLBACKS
  after_create :discount_price
  after_create :update_survivor_user_id

  #METHODS
  protected


  def available_entrys
  	 user_total = SurvivorUser.where('survivor_week_survivor_id = ?', survivor_week_survivor.id).pluck(:user_id).uniq().count
	 survivor_max = survivor_week_survivor.survivor.user_quantity 
	 
	  if user_total > survivor_max
		  errors.add(:user_id, "No puedes comprar la entrada por que la liga tiene su maximo de usuarios.")
	  end	  
	  
  end	
	
  def available_rebuy
    losses = survivor_week_survivor.survivor.survivor_users.where(:survivor_user_id => survivor_user_id).loser.count
    rebuy_quantity = survivor_week_survivor.survivor.rebuy_quantity

    if losses > rebuy_quantity
      errors.add(:user_id, I18n.t("no_rebuy_available"))
    end
  end

	def update_survivor_user_id
		if survivor_user_id.blank?
			update({survivor_user_id: id})
		end
	end

  def available_team
    team_ids = survivor_week_survivor.survivor.survivor_users.where(:survivor_user_id => survivor_user_id).pluck(:team_id)
	  puts "/////////////////////////////////////"
	  puts team_ids.inspect
	  puts team_id.inspect

    if team_ids.include?(team_id)
      errors.add(:team_id, I18n.t("team_already_selected"))
    end
  end

  def discount_price
	 previous_survivor_week_survivor = survivor_week_survivor.previous_survivor_week_survivor

    if previous_survivor_week_survivor.nil? || previous_survivor_week_survivor.survivor_users.alive.find_by(:survivor_user_id => survivor_user_id).nil?
    	if user.gift_credit.to_f >= survivor_week_survivor.survivor.price.to_f
        user.update(:gift_credit => user.gift_credit.to_f - survivor_week_survivor.survivor.price.to_f)
    	else
        user.update(:balance => user.balance - survivor_week_survivor.survivor.price)
    	end
    end
  end
end
