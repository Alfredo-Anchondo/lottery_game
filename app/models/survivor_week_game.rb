class SurvivorWeekGame < ActiveRecord::Base
  #ASSOCIATIONS
  belongs_to :survivor
  has_many :survivor_games

  #VALIDATIONS
  validates :survivor_id, :initial_date, :final_date, :week, :presence => true
  validates :initial_date, :final_date, overlap: { scope: "survivor_id",
    message_content: I18n.t("errors.messages.overlaps_with_another_range") }
  validate :initial_date_lesser_than_final_date

  #METHODS
	def select_display
		"#{survivor.name} #{I18n.t("week")} #{week}"
	end

  protected

  def initial_date_lesser_than_final_date
    errors.add(:initial_date, I18n.t("errors.messages.initial_date_lesser_than_final_date")) if initial_date >= final_date
  end
end
