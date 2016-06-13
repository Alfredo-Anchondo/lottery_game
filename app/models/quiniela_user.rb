class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
	
	
		def self.sales_by_month
		array_months = []
		month_label = ''
		sales_month = []
		for i in 1..12
			@quiniela =  where('extract(month from purchase_date) = ?', i)
			@month_sale = @quiniela.count
			total = 0
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
			@quiniela.each do |quiniela|
				total += Integer(quiniela.quiniela.price)
			end
			array_months.push({month: month_label , sales: @month_sale})
			sales_month.push({month: month_label, money: total})
		end
		return { tickets: array_months, sales: sales_month } 
	end
	
	def self.today_sales(date1, date2)
		
		@quinielas = where(purchase_date: date1..date2)
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
