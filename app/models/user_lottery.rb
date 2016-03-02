class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery    
    
      def select_display
      name
    end
    
    def self.hello(lottery_id_param)
        logger.info lottery_id_param
        logger.info where('lottery_id = ?', lottery_id_param).first
    end    
    
end
