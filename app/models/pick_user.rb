class PickUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :pick_survivor_week
  has_one :pick,  :through => :pick_survivor_week
  belongs_to :pick_user
  has_many :pick_user_games

  after_create :update_survivor_user_id
  after_create :discount_price
  after_create :send_buy_mail
  before_create :tickets_quantity
  before_create :check_if_exist

	def update_survivor_user_id
		if pick_user_id.blank?
			update({pick_user_id: id})
		end
	end

  def total_points
    total = 0
    PickUser.where("pick_user_id = ?",pick_user_id).each do |pick|
      total += pick.points ? pick.points : 0
    end
    return total
  end

def select_display
  user.name + "-" + pick.name + "" + id.to_s
end

  def check_if_exist
    if PickUser.where("user_id = ? and pick_survivor_week_id = ? and pick_user_id = ?", user_id, pick_survivor_week_id, pick_user_id).count != 0
      return false
    end
  end

    def tickets_quantity
          if pick.id == 8
          if SurvivorUser.where("user_id = ? and survivor_week_survivor_id = ?",user.id,pick_survivor_week.id).count >= 2
              return false
          end

      end
    end

  def send_buy_mail
	  if pick_survivor_week.survivor_week_game.week == 0
		 week_1 = SurvivorWeekGame.find_by week: 1, sport_category:  pick_survivor_week.pick.sport_category_id
		 BuyMailer.buy_pick_entry(pick_survivor_week.pick, user, week_1 ).deliver
	  else

	  end
  end

  def discount_price
	  if pick_survivor_week.survivor_week_game.week == 0
		 if user.gift_credit.to_f >= pick_survivor_week.pick.price.to_f
        user.update(:gift_credit => user.gift_credit.to_f - pick_survivor_week.pick.price.to_f)
            if pick.id == 12
                else
		pick.update(:initial_balance => pick.initial_balance + pick.price)
            end
    	else
        user.update(:balance => user.balance - pick_survivor_week.pick.price)
             if pick.id == 12
                 else
     	pick.update(:initial_balance => pick.initial_balance + pick.price)
             end
    	end
	  else

	  end

  end
end
