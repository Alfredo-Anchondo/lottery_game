class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    
    def select_display
      name
    end
	
	def self.today_sales(date1, date2)
		@lotteries = where(purchase_date: date1..date2)
		logger.info @lotteries.to_sql
		logger.info @lotteries.count
		@lotteries_total = @lotteries.count
		@dates = []
		@total_sales = 0
		@date_array =[]
		@sales_array = []
		@total = 0
		@lotteries.each do |lottery|
			@total_sales = @total_sales + lottery.lottery.price
			@dates.push(lottery.purchase_date.strftime('%Y-%m-%d'))
		end
		logger.info @dates
		@dates = @dates.uniq{|x| x}
		@dates = @dates.sort
		@dates.each do |date|
			@total = 0;
			sales_day = @lotteries.where('purchase_date > ? AND purchase_date < ?',date,(Date.parse(date)+1))
			sales_day.each do |sale|
				@total += Integer(sale.lottery.price)
			end
			@date_array.push({label: date, cuantity: @lotteries.where('purchase_date >= ? AND purchase_date <= ?',Date.parse(date),(Date.parse(date)+1)).count})
			@sales_array.push({label:date, sales: @total })
		end
		logger.info @dates
		logger.info @date_array
		return {totals: [@lotteries_total,@total_sales], date_array: @date_array, total_sales: @sales_array}
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
