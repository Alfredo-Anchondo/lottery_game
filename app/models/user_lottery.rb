class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery    
    
      def select_display
      name
    end
    
    def hello
        logger.info "Entre desde el modelo user lotteries"
    end    
    
end
