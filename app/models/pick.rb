class Pick < ActiveRecord::Base
  belongs_to :user
  has_many :pick_survivor_weeks
  has_many :survivor_week_games, :through => :pick_survivor_weeks
  has_many :survivor_games, :through => :survivor_week_games
  has_many :pick_users, :through => :pick_survivor_weeks
  has_many :users, :through => :pick_users	
	
  has_attached_file :background, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default_background.png"
  validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/	
	
	
	
	def background_url
		background.url
	end
	
	def alive_users
		users ? users.count : 0
  	end
	
	
end
