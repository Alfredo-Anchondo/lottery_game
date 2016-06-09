class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
	
	def self.today_sales(date1, date2)
		
		@quinielas = where(purchase_date: date1..String(Date.parse(date2) - 5.hours))
		@quinielas_total = @quinielas.count
		@total_sales = 0
		@dates =[]
		@date_array =[]
		@sales_array = []
		@total = 0
		@quinielas.each do |quiniela|
			@total_sales = @total_sales + Integer(quiniela.quiniela.price)
			@dates.push(quiniela.purchase_date.strftime('%Y-%m-%d'))
		end
		@dates = @dates.uniq{|x| x}
		@dates = @dates.sort
		logger.info @total_sales
	    @dates.each do |date|
			@total = 0;
			sales_day = @quinielas.where('purchase_date > ? AND purchase_date < ?',date,(Date.parse(date)+1))
			sales_day.each do |sale|
				@total += Integer(sale.quiniela.price)
			end
			@date_array.push({label:date, cuantity: @quinielas.where('purchase_date >= ? AND purchase_date <= ?',Date.parse(date),(Date.parse(date)+1)).count })
			@sales_array.push({label:date, sales: @total })
		end
		return {totals: [@quinielas_total,@total_sales], date_array: @date_array, total_sales: @sales_array}
	end
	
	 def self.winners
		 where('status >= ?', 'Ganador').order(quiniela_id: :desc)
    end
	
end
