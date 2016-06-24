class SurvivorUser < ActiveRecord::Base
  #SCOPE
  scope :bought, -> { where(:status => "bought") }
  scope :loser, -> { where(:status => "loser") }
  scope :alive, -> { where(:status => "alive") }
  scope :winner, -> { where(:status => "winner") }

  #ASSOCIATIONS
  belongs_to :survivor_week_survivor
  belongs_to :team
  belongs_to :user

  #VALIDATIONS
  validates :survivor_week_survivor_id, :team_id, :user_id, :presence => true
  validate :available_rebuy, :on => :create

  #CALLBACKS
  before_create :discount_price

  #METHODS
  protected

  def available_rebuy
    losses = survivor_week_survivor.survivor.survivor_users.where(:user_id => user_id).loser.count
    rebuy_quantity = survivor_week_survivor.survivor.rebuy_quantity

    if losses > rebuy_quantity
      errors.add(:user_id, I18n.t("no_rebuy_available"))
    end
  end

  def discount_price
    previous_survivor_week_survivor = survivor_week_survivor.previous_survivor_week_survivor

    if previous_survivor_week_survivor.nil? || previous_survivor_week_survivor.survivor_users.alive.find_by(:user_id => user.id).nil?
      user.update(:balance => user.balance - survivor_week_survivor.survivor.price)
    end
  end
end
