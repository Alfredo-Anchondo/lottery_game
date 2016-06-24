class Survivor < ActiveRecord::Base
  #SCOPES
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM created_at) = ?", year) }

  #ASSOCIATIONS
  belongs_to :user
  has_many :survivor_week_survivors
  has_many :survivor_week_games, :through => :survivor_week_survivors
  has_many :survivor_games, :through => :survivor_week_games
  has_many :survivor_users, :through => :survivor_week_survivors

  #VALIDATIONS
  validates :name, :price, :initial_balance, :presence => true
  validates :price, :initial_balance, :numericality => { :greater_than => 0 }

  #METHODS

  def alive_users
    last_survivor_week_game = SurvivorWeekGame.from_year.order(:initial_date).last
    survivor_users.where(:survivor_week_game_id => last_survivor_week_game.id).alive
  end

  def self.close
    if SurvivorGame.no_pending_games? && survivor_week_games.last.last_week? && !survivor_week_games.last.closed
      from_year.each do |s|
        total_winners = s.survivor_users.winner.count

        if total_winners > 0 && s.initial_balance > 0
          if s.percentage.present?
            percentage_profit = s.initial_balance * s.percentage.to_s / 100
            s.user.update(:balance => s.user.balance + percentage_profit.to_f / 2)
            profit = (s.initial_balance.to_f - percentage_profit) / total_winners
          else
            profit = s.initial_balance.to_f / total_winners
          end

          s.survivor_users.winner.each do |su|
            su.user.update(:balance => su.user.balance + profit)
            su.survivor_week_survivor.survivor_week_game.update(:closed => true)
          end
        end
      end
    end
  end
end
