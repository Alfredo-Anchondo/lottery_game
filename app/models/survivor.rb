class Survivor < ActiveRecord::Base
  #SCOPES
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM created_at) = ?", year) }

  #ASSOCIATIONS
  belongs_to :user
  has_many :survivor_week_survivors
  has_many :survivor_week_games, :through => :survivor_week_survivors
  has_many :survivor_games, :through => :survivor_week_games
  has_many :survivor_users, :through => :survivor_week_survivors
  has_many :users, :through => :survivor_users

  has_attached_file :background, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/default_background.png"
  validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/

  #VALIDATIONS
  validates :name, :price, :initial_balance, :presence => true
  validates :price, :initial_balance, :numericality => { :greater_than => 0 }

  #METHODS

	def user_username
		User.find(user_id).username
	end

    def winner_user
      survivor_users.where('status =?','winner').count
    end

  def alive_users
	@current_week = survivor_week_games.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now,6)
	  if @current_week[0].week == 0
		  last_survivor_week_game = survivor_week_games.from_year.find(@current_week[0].id )
      else
		  last_survivor_week_game = survivor_week_games.from_year.find(@current_week[0].id - 1)
	  end

	survivor_week_survivor = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?',id, last_survivor_week_game.id)
   alives = survivor_users.where(:survivor_week_survivor_id => survivor_week_survivor[0].id).alive
   losers = survivor_users.where('survivor_week_survivor_id = ? and status = ?', survivor_week_survivor[0].id,'loser')
   already_rebuy =  survivor_users.where('survivor_week_survivor_id = ? and status = ?', survivor_week_survivor[0].id,'alreadyrebuy')
      loser_count = 0
      losers.each do |loser|
       loser_count += SurvivorUser.where('survivor_user_id = ? and status =? and survivor_week_survivor_id = ?' , loser.survivor_user_id,'loser',survivor_week_survivor[0].id).count
      end
      return alives.count
      #Desactivado temporalmente para este survivor
      #return alives.count + loser_count + already_rebuy.count

  end

	def background_url
		background.url
	end


	def participant_users
		users.uniq
	end

  def self.close
    if SurvivorGame.no_pending_games? && SurvivorWeekGame.from_year.last.last_week?
      from_year.each do |s|
        total_winners = s.survivor_users.winner.count

        if total_winners > 0 && s.initial_balance > 0
          if s.percentage.present?
            percentage_profit = s.initial_balance * s.percentage.to_f / 100
            s.user.update(:balance => s.user.balance + percentage_profit.to_f / 2)
            profit = (s.initial_balance.to_f - percentage_profit) / total_winners
          else
            profit = s.initial_balance.to_f / total_winners
          end

          s.survivor_users.winner.each do |su|
            su.user.update(:balance => su.user.balance + profit)
			BuyMailer.winner_survivor(s,su.user,s.survivor_users.winner.count,profit).deliver
          end
        end
      end

      SurvivorWeekGame.from_year.last.update(:closed => true)
    end
  end
end
