class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
	
	def self.today_sales(date1, date2)
		
		@quinielas = where('purchase_date > ? AND purchase_date < ?',date1,date2)
		@quinielas_total = @quinielas.count
		@total_sales = 0;
		@quinielas.each do |quiniela|
			@total_sales = @total_sales + Integer(quiniela.quiniela.price)
		end
		logger.info @total_sales
		return [@quinielas_total,@total_sales]
	end
	
	 def self.winners
		 where('status >= ?', 'Ganador').order(quiniela_id: :desc)
    end
	
end
