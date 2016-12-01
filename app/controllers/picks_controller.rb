class PicksController < ApplicationController
    load_and_authorize_resource
  before_action :set_pick, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @picks = Pick.all
    respond_with(@picks)
  end

  def show
    respond_with(@pick)
  end

  def new
    @pick = Pick.new
    respond_with(@pick)
  end

  def edit
  end

  def create
    @pick = Pick.new(pick_params)
    @pick.save
    respond_with(@pick)

	    SurvivorWeekGame.current_year.where('sport_category = ?', @pick.sport_category_id).each do |week|
		survivor1 = PickSurvivorWeek.new(:pick_id => @pick.id, :survivor_week_game_id => week.id )
		  survivor1.save
	  end

  end

  def update
    @pick.update(pick_params)
    respond_with(@pick)
  end



  def destroy
    @pick.destroy
    respond_with(@pick)
  end

  private
    def set_pick
      @pick = Pick.find(params[:id])
    end

    def pick_params
      params.require(:pick).permit(:name, :description, :user_id, :price, :sport_category_id, :initial_balance, :background, :access_key, :pick_type, :winner_type, :first_percentage, :second_percentage, :third_percentage, :to_mainpage , :users_quantity,:percentage_per_week, :percentage)
    end
end
