class QuinielaUser < ActiveRecord::Base
	has_many :users
	has_many :quinielas
	belongs_to :user
	belongs_to :quiniela
end
