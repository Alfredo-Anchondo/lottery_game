class SurvivorUser < ActiveRecord::Base
  #SCOPE
  scope :alive, -> { where(:status => "alive") }
  scope :winner, -> { where(:status => "winner") }

  #ASSOCIATIONS
  belongs_to :survivor_week_survivor
  belongs_to :team
  belongs_to :user

  #ASSOCIATIONS
  validate :survivor_week_survivor_id, :team_id, :user_id, :presence => true
end
