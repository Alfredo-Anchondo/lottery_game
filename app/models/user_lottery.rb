class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery
    
      def select_display
      name
    end
    
end
