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
end
