class SurvivorsController < ApplicationController
  load_and_authorize_resource except: [:new, :create, :update, :edit]
  before_action :authenticate_user!
  before_action :set_survivor, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @survivors = Survivor.all
    respond_with(@survivors)
  end

  def show
    respond_with(@survivor)
  end

  def new
    @survivor = Survivor.new
    respond_with(@survivor)
  end

  def edit
  end

  def create
    @survivor = Survivor.new(survivor_params)
    @survivor.save
    respond_with(@survivor)
	    SurvivorWeekGame.current_year.where('sport_category = ?',6).each do |week|
		survivor1 = SurvivorWeekSurvivor.new(:survivor_id => @survivor.id, :survivor_week_game_id => week.id )
		  survivor1.save
	  end
  end

  def update
    @survivor.update(survivor_params)
    respond_with(@survivor)
  end

  def destroy
    @survivor.destroy
    respond_with(@survivor)
  end

  def close
    Survivor.close
    render :nothing => true
  end

  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    def survivor_params
      params.require(:survivor).permit(:name, :description, :access_key, :price, :user_id, :percentage, :initial_balance, :rebuy_quantity, :background, :user_quantity, :status)
    end
end
