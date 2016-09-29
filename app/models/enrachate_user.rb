class EnrachateUser < ActiveRecord::Base
  belongs_to :question_enrachate
  belongs_to :tira_enrachate
  belongs_to :enrachate    
  belongs_to :user
    
  before_create :update_user_balance
  after_create :update_enrachate_user_id
    
    
    
  def update_enrachate_user_id
		if enrachate_user_id.blank?
			update({enrachate_user_id: id})
		end
  end    
    
  def racha  
      EnrachateUser.where("enrachate_user_id = ? and status = ? ",enrachate_user_id, "alive").count
  end
    
  def update_user_balance
       @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ?",0,Time.now,Time.now).first 
      
        if @enrachate.future_tira != nil && @enrachate.future_tira != "" && @enrachate.future_tira != []
          if @enrachate.future_tira.id = tira_enrachate_id
              return "ok"
          end
        end
      
      if @enrachate.past_tira != "" && @enrachate.past_tira != [] && @enrachate.past_tira != nil
       @alive_buy = EnrachateUser.where("user_id = ? and status = ? and enrachates_id = ? and tira_enrachate_id = ?", user.id, "alive", @enrachate.id, @enrachate.past_tira.id)
      end
      
      if @alive_buy != "" && @alive_buy != [] && @alive_buy != nil
          else
        if user.gift_credit.to_f > Enrachate.find(enrachates_id).price
            user.update(:gift_credit => user.gift_credit.to_f - Enrachate.find(enrachates_id).price)
            Enrachate.find(enrachates_id).update(:initial_balance => Enrachate.find(enrachates_id).price * 0.20 + Enrachate.find(enrachates_id).initial_balance )
            else if user.balance.to_f > Enrachate.find(enrachates_id).price
            user.update(:balance => user.balance.to_f - Enrachate.find(enrachates_id).price)
            Enrachate.find(enrachates_id).update(:initial_balance => Enrachate.find(enrachates_id).price * 0.20 + Enrachate.find(enrachates_id).initial_balance )
        else
            return false
        end
      end
    end
  end
    
end
