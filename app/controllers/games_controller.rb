class GamesController < ApplicationController
	 load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :data, only: [:index, :new, :create, :edit, :update]
  respond_to :html, :json

  # GET /games
  # GET /games.json
  def index
  end

  # GET /games/1
  # GET /games/1.json
  def show
  
  end
	
	def select_display
		  team.name + " vs " + team2.name
	end
	

  # GET /games/new
  def new
    @game = Game.new
  end

    def next_game
        render :json => Game.next_game 
    end
    
    def today_games
        render :json => Game.today_games 
    end
    
    def future_games
        render :json => Game.future_games
    end
    
      def finish_games
        render :json => Game.finish_games
    end
    
    def lottery_name
      @game = Game.find(params[:id])
      respond_with(@game.team.name + " VS " + @game.team2.name)
    end
    
  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
          format.html { redirect_to @game, notice: t('success_update_game') }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:team_id, :game_date, :description, :local_score, :visit_score, :team2_id)
    end
end
