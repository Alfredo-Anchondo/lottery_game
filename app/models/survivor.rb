class Survivor < ActiveRecord::Base
  #ASSOCIATIONS
  belongs_to :user
  has_many :survivor_week_survivors
  has_many :survivor_week_games, :through => :survivor_week_survivors
 	
  has_many :survivor_games, :through => :survivor_week_games
  has_many :survivor_users, :through => :survivor_week_games

  #VALIDATIONS
  validates :name, :price, :initial_balance, :presence => true
  validates :price, :initial_balance, :numericality => { :greater_than => 0 }

  #METHODS

  def alive_users
    survivor_week_games.order(:initial_date).last.survivor_users.alive
  end

  def close
    if !closed && survivor_games.count == survivor_games.where.not(:local_score => nil, :visit_score => nil).count
      total_winners = survivor_users.winner.count

      if total_winners > 0 && initial_balance > 0
        profit = initial_balance.to_f / total_winners

        survivor_users.winner.each do |s|
          s.user.update(:balance => s.user.balance + profit)
        end

        update(:closed => true)
        return true
      end
    end

    return false
  end
end
