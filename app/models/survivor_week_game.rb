class SurvivorWeekGame < ActiveRecord::Base
  #SCOPES
  default_scope -> { order(:week) }
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM initial_date) = ?", year) }

  #ASSOCIATIONS
  has_many :survivor_week_survivors
  has_many :survivor_games
  has_many :survivor_users, :through => :survivor_week_survivors

  #VALIDATIONS
  validates :initial_date, :final_date, :week, :presence => true
  validate :initial_date_lesser_than_final_date

  #METHODS

	def self.current_year
		where('extract(year  from initial_date) = ?', Time.now.year)
	end

	def select_display
		"#{I18n.t("week")} #{week}"
	end

  def first_week?
    week == 1
  end

  def last_week?
    week == 17
  end

  def can_close?
    last_week? && SurvivorGame.no_pending_games? && !closed
  end

  protected

  def initial_date_lesser_than_final_date
    errors.add(:initial_date, I18n.t("errors.messages.initial_date_lesser_than_final_date")) if initial_date >= final_date
  end
end
