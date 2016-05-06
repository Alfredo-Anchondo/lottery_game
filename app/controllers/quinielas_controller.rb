class QuinielasController < ApplicationController
  before_action :set_quiniela, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json	

	def get_quinielas
		@quinielas = Quiniela.all
		render :json => @quinielas		
	end
	
	def get_quinielas_no_winner	
		render :json => Quiniela.find_no_winners 		
	end
	
	
  def index
    @quinielas = Quiniela.all
    respond_with(@quinielas)
  end

  def show
    respond_with(@quiniela)
  end

  def new
    @quiniela = Quiniela.new
	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
    @quiniela.quiniela_questions.build
  	@quiniela.quiniela_questions.build
	@quiniela.quiniela_questions.build
    respond_with(@quiniela)
  end

  def edit
	  @quiniela.quiniela_questions.build
  end

  def create
    @quiniela = Quiniela.new(quiniela_params)
    @quiniela.save
    respond_with(@quiniela)
  end

  def update
    @quiniela.update(quiniela_params)
    respond_with(@quiniela)
  end

  def destroy
    @quiniela.destroy
    respond_with(@quiniela)
  end

  private
    def set_quiniela
      @quiniela = Quiniela.find(params[:id])
    end

    def quiniela_params
		params.require(:quiniela).permit(:initial_balance, :price, :game_id, :description, :winner_number, quiniela_questions_attributes: [:id, :question_id, :_destroy])
    end
	
      
end
