class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
	
	def self.today_sales(date1, date2)
		
		@quinielas = where('purchase_date > ? AND purchase_date < ?',date1,date2)
		@quinielas_total = @quinielas.count
		@total_sales = 0;
		@dates =[]
		@date_array =[]
		@quinielas.each do |quiniela|
			@total_sales = @total_sales + Integer(quiniela.quiniela.price)
			@dates.push(quiniela.purchase_date.strftime('%Y-%m-%d'))
		end
		@dates = @dates.uniq{|x| x}
		logger.info @total_sales
		@dates.each do |date|
			@date_array.push({label:date, cuantity: @quinielas.where('purchase_date > ? AND purchase_date < ?',date,(Date.parse(date)+1)).count})
		end
		return {totals: [@quinielas_total,@total_sales], date_array: @date_array}
	end
	
	 def self.winners
		 where('status >= ?', 'Ganador').order(quiniela_id: :desc)
    end
	
end
