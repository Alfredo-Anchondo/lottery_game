class SurvivorWeekGame < ActiveRecord::Base
  #SCOPES
  default_scope -> { order(:week) }

  #ASSOCIATIONS
  belongs_to :survivor
  has_many :survivor_games
  has_many :survivor_users

  #VALIDATIONS
  validates :survivor_id, :initial_date, :final_date, :week, :presence => true
  validates :initial_date, :final_date, overlap: { scope: "survivor_id",
    message_content: I18n.t("errors.messages.overlaps_with_another_range") }
  validate :initial_date_lesser_than_final_date
  validates :week, :uniqueness => { :scope => [:survivor_id] }

  #METHODS
	def select_display
		"#{survivor.name} #{I18n.t("week")} #{week}"
	end

  def last_week?
    week == 17
  end

  def no_pending_games?
    survivor_games.count == survivor.survivor_games.where.not(:local_score => nil, :visit_score => nil).count
  end

  def can_close?
    last_week? && no_pending_games? && survivor.initial_balance > 0
  end

  protected

  def initial_date_lesser_than_final_date
    errors.add(:initial_date, I18n.t("errors.messages.initial_date_lesser_than_final_date")) if initial_date >= final_date
  end
end
