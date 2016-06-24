class SurvivorWeekSurvivor < ActiveRecord::Base
  #ASSOCIATIONS
  belongs_to :survivor
  belongs_to :survivor_week_game
  has_many :survivor_users

  #VALIDATIONS
  validates :survivor, :survivor_week_game, :presence => true

  #METHODS
  def select_display
    "#{survivor.name} / #{survivor_week_game.select_display}"
  end

  def previous_survivor_week_survivor
    survivor.survivor_week_survivors.joins(:survivor_week_game).order("survivor_week_games.week DESC").where("survivor_week_games.week < ?", survivor_week_game.week).first
  end
end
