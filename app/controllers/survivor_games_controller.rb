class SurvivorGamesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_survivor_game, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @survivor_games = SurvivorGame.all
    respond_with(@survivor_games)
  end

  def show
    respond_with(@survivor_game)
  end

  def new
    @survivor_game = SurvivorGame.new
    respond_with(@survivor_game)
  end

  def edit
  end

  def create
    @survivor_game = SurvivorGame.new(survivor_game_params)
    @survivor_game.save
    respond_with(@survivor_game)
  end

  def update
    @survivor_game.update(survivor_game_params)
    respond_with(@survivor_game)
  end

  def destroy
    @survivor_game.destroy
    respond_with(@survivor_game)
  end

  private
  def set_survivor_game
    @survivor_game = SurvivorGame.find(params[:id])
  end

  def survivor_game_params
    params.require(:survivor_game).permit(:team_id, :team2_id, :handicap, :plus_handicap, :description, :game_date, :winner_team, :local_score, :visit_score, :survivor_week_game_id)
  end
end
