class SurvivorGame < ActiveRecord::Base
  #SCOPES
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM game_date) = ?", year) }

  #ASSOCIATIONS
  belongs_to :team
  belongs_to :team2
  belongs_to :survivor_week_game

  #VALIDATIONS
  validate :team_id, :team2_id, :survivor_week_game_id, :game_date, :presence => true

  #CALLBACKS
  before_update :change_status

  #METHODS
  def self.no_pending_games?
    SurvivorGame.from_year.count == SurvivorGame.from_year.where.not(:local_score => nil, :visit_score => nil).count
  end

  protected

  def change_status
    if winner_team_changed?
      loser_team = (winner_team == team_id)? team2_id: team_id
      winner_status = (survivor_week_game.last_week?)? "winner": "alive"

      survivor_week_game
      .survivor_users
      .where(:team_id => winner_team)
      .update_all(:status => winner_status)

      survivor_week_game
      .survivor_users
      .where(:team_id => loser_team)
      .update_all(:status => "loser")
    end
  end
end
