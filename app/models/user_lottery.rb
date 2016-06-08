class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    
    def select_display
      name
    end
	
	def self.today_sales(date1, date2)
		@lotteries = where('purchase_date > ? AND purchase_date <= ?',date1,date2)
		@lotteries_total = @lotteries.count
		@total_sales = 0;
		@lotteries.each do |lottery|
			@total_sales = @total_sales + lottery.lottery.price
		end
		logger.info @total_sales
		return [@lotteries_total,@total_sales]
	end
 
    def self.winners
        where('status >= ?', 'Ganador').order(lottery_id: :desc)
    end
    
    def self.winners_total
        where('status >= ?', 'Ganador').pluck(:lottery_id).uniq.count 
    end
	
	def self.search_ticket_by_lottery(id)
		where('lottery_id = ?', id).all
	end
	
end
