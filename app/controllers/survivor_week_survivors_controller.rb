class SurvivorWeekSurvivorsController < ApplicationController
  before_action :set_survivor_week_survivor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @survivor_week_survivors = SurvivorWeekSurvivor.all
    respond_with(@survivor_week_survivors)
  end

  def show
    respond_with(@survivor_week_survivor)
  end

  def new
    @survivor_week_survivor = SurvivorWeekSurvivor.new
    respond_with(@survivor_week_survivor)
  end

  def edit
  end

  def create
    @survivor_week_survivor = SurvivorWeekSurvivor.new(survivor_week_survivor_params)
    @survivor_week_survivor.save
    respond_with(@survivor_week_survivor)
  end

  def update
    @survivor_week_survivor.update(survivor_week_survivor_params)
    respond_with(@survivor_week_survivor)
  end

  def destroy
    @survivor_week_survivor.destroy
    respond_with(@survivor_week_survivor)
  end

  private
    def set_survivor_week_survivor
      @survivor_week_survivor = SurvivorWeekSurvivor.find(params[:id])
    end

    def survivor_week_survivor_params
      params.require(:survivor_week_survivor).permit(:survivor_id, :survivor_week_game_id)
    end
end
