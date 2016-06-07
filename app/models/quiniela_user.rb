class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
	
	def self.today_sales(date1, date2)
		where('purchase_date > ? AND purchase_date < ?',date1,date2).count
	end
	
	 def self.winners
		 where('status >= ?', 'Ganador').order(quiniela_id: :desc)
    end
	
end
