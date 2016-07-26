class PickUserGamesController < ApplicationController
  before_action :set_pick_user_game, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pick_user_games = PickUserGame.all
    respond_with(@pick_user_games)
  end

  def show
    respond_with(@pick_user_game)
  end

  def new
    @pick_user_game = PickUserGame.new
    respond_with(@pick_user_game)
  end

  def edit
  end

  def create
    @pick_user_game = PickUserGame.new(pick_user_game_params)
    @pick_user_game.save
    respond_with(@pick_user_game)
  end

  def update
    @pick_user_game.update(pick_user_game_params)
    respond_with(@pick_user_game)
  end

  def destroy
    @pick_user_game.destroy
    respond_with(@pick_user_game)
  end

  private
    def set_pick_user_game
      @pick_user_game = PickUserGame.find(params[:id])
    end

    def pick_user_game_params
      params.require(:pick_user_game).permit(:pick_user_id, :points, :team_id, :survivor_game_id)
    end
end
