class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery
  has_many :user_lotteries    
    
      def select_display
      name
    end
    
end
