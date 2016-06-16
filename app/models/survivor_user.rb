class SurvivorUser < ActiveRecord::Base
  #SCOPE
  scope :alive, -> { where(:status => "alive") }

  #ASSOCIATIONS
  belongs_to :survivor_week_game
  belongs_to :team
  belongs_to :user

  #ASSOCIATIONS
  validate :survivor_week_game_id, :team_id, :user_id, :presence => true
end
