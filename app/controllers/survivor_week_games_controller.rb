class SurvivorWeekGamesController < ApplicationController
  load_and_authorize_resource except: [:new,:create, :get_games, :can_close]
  before_action :authenticate_user!
  before_action :set_survivor_week_game, only: [:show, :edit, :update, :destroy, :get_games, :can_close]

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

	def get_weeks
		  render :json => SurvivorWeekGame.where('sport_category = ?', params[:id])
	end
	
	
	def get_games
		render :json => {
      :id => @survivor_week_game.id,
      :can_close => @survivor_week_game.can_close?,
      :last_week => @survivor_week_game.last_week?,
      :survivor_games => @survivor_week_game.survivor_games.map do |s|
        s.attributes.merge(
          :survivor_week_game => s.survivor_week_game,
          :team => s.team.attributes.merge(:logo_url => s.team.logo_url),
          :team2 => s.team2.attributes.merge(:logo_url => s.team2.logo_url)
        )
      end
    }
	end

  def can_close
    render :json => { :can_close => @survivor_week_game.can_close? }
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
      params.require(:survivor_week_game).permit(:survivor_id, :sport_category, :initial_date, :final_date, :week)
    end
end
