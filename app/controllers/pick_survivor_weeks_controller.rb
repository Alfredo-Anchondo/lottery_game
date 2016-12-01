class PickSurvivorWeeksController < ApplicationController
  load_and_authorize_resource 
  before_action :set_pick_survivor_week, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pick_survivor_weeks = PickSurvivorWeek.all
    respond_with(@pick_survivor_weeks)
  end

  def show
    respond_with(@pick_survivor_week)
  end

  def new
    @pick_survivor_week = PickSurvivorWeek.new
    respond_with(@pick_survivor_week)
  end

  def edit
  end

  def create
    @pick_survivor_week = PickSurvivorWeek.new(pick_survivor_week_params)
    @pick_survivor_week.save
    respond_with(@pick_survivor_week)
  end

  def update
    @pick_survivor_week.update(pick_survivor_week_params)
    respond_with(@pick_survivor_week)
  end

  def destroy
    @pick_survivor_week.destroy
    respond_with(@pick_survivor_week)
  end

  private
    def set_pick_survivor_week
      @pick_survivor_week = PickSurvivorWeek.find(params[:id])
    end

    def pick_survivor_week_params
      params.require(:pick_survivor_week).permit(:pick_id, :survivor_week_game_id)
    end
end
