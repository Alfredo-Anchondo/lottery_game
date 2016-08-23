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
    
    def entry_quantity
        pick_users.where("")
    end
	
	def alive_users
       zero_pick = pick_survivor_weeks.where(:survivor_week_game_id => survivor_week_games.where(:week => 0).pluck(:id) )
		pick_users ? pick_users.where('pick_survivor_week_id = ?', zero_pick[0].id).count : 0
  	end
    
    def week_amount
        if pecentage_per_week.exist?
        percentage_per_week/100 * initial_balance
            else
            return 0
        end
    end
	
	
end
