class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    
    def select_display
      name
    end
 
    def self.winners
        where('status >= ?', 'Ganador').order(lottery_id: :desc)
    end
    
    def self.winners_total
        where('status >= ?', 'Ganador').pluck(:lottery_id).uniq.count 
    end
	
end
