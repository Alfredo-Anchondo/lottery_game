class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    has_one :user
    has_one :lottery
    
      def select_display
      name
    end
    
 
    
end
