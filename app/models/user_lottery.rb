class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    
      def select_display
      name
    end
    
 
    def self.winners
        where('status >= ?', 'Ganador').order(:purchase_date)
    end
    
    def winners_total
        where('status >= ?', 'Ganador').count 
    end
end
