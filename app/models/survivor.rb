class Survivor < ActiveRecord::Base
  #ASSOCIATIONS
  has_many :survivor_week_games
  has_many :survivor_games, :through => :survivor_week_games
  has_many :survivor_users, :through => :survivor_week_games

  #VALIDATIONS
  validates :name, :price, :initial_balance, :presence => true
  validates :price, :initial_balance, :numericality => { :greater_than => 0 }

  #METHODS

  def alive_users
    survivor_week_games.order(:initial_date).last.survivor_users.alive
  end
end
