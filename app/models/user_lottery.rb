class UserLottery < ActiveRecord::Base
  belongs_to :user
  belongs_to :lottery   
    
    def select_display
      name
    end
	
	def self.sales_by_month
		array_months = []
		month_label = ''
		sales_month = []
	
		for i in 1..12
			total = 0
			@lotteries = where('extract(month from purchase_date) = ?', i)
			@month_sale = @lotteries.count
			case i
			when 1
			  month_label = 'Enero'
			when 2
			  month_label = 'Febrero'
			when 3
			  month_label = 'Marzo'
			when 4
			 month_label = 'Abril'
			when 5
			   month_label = 'Mayo'
			when 6
			   month_label = 'Junio'
			when 7
			  month_label = 'Julio'
			when 8
			   month_label = 'Agosto'
			when 9
			   month_label = 'Septiembre'
			when 10
			 month_label = 'Octubre'
			when 11
			  month_label = 'Noviembre'
			when 12
			  month_label = 'Diciembre'
			else
			  puts "You just making it up!"
			end
			@lotteries.each do |lottery|
				total += Integer(lottery.lottery.price)
			end
			sales_month.push({month: month_label, money: total})
			array_months.push({month: month_label , sales: @month_sale})
		end
		return { tickets: array_months, sales: sales_month } 
	end
	
	
	def self.today_sales(date1, date2)
		@lotteries = where(purchase_date: date1..date2)
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
