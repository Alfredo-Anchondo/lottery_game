class SurvivorWeekGamesController < ApplicationController
  load_and_authorize_resource except: [:new,:create]
  before_action :authenticate_user!
  before_action :set_survivor_week_game, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @survivor_week_games = SurvivorWeekGame.all
    respond_with(@survivor_week_games)
  end

  def show
    respond_with(@survivor_week_game)
  end

  def new
    @survivor_week_game = SurvivorWeekGame.new
    respond_with(@survivor_week_game)
  end

  def edit
  end
	
	def get_games
		render :json => SurvivorWeekGame.get_games(params[:id])
	end

  def create
    @survivor_week_game = SurvivorWeekGame.new(survivor_week_game_params)
    @survivor_week_game.save
    respond_with(@survivor_week_game)
  end

  def update
    @survivor_week_game.update(survivor_week_game_params)
    respond_with(@survivor_week_game)
  end

  def destroy
    @survivor_week_game.destroy
    respond_with(@survivor_week_game)
  end

  private
    def set_survivor_week_game
      @survivor_week_game = SurvivorWeekGame.find(params[:id])
    end

    def survivor_week_game_params
      params.require(:survivor_week_game).permit(:survivor_id, :initial_date, :final_date, :week)
    end
end
