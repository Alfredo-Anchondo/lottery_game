class QuinielasController < ApplicationController
  before_action :set_quiniela, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json	

	
	def buy_random_quinielas
		@numbers = params[:numbers]
		@price = params[:price]
		@balance = params[:balance]
		@user = current_user
		@tira = params[:tira_id]
		@normal_buy = params[:normal_buy]
		@total_balance_update = params[:total_balance_update]
		@quiniela = Quiniela.find(params[:tira_id]);
		@purchase_gift = @quiniela.purchase_gift_tickets
		if @purchase_gift == '' || @purchase_gift == "NaN" || @purchase_gift == nil
			@purchase_gift = 0
		end
		
		render nothing: true

		if params[:normal_buy] != 'true'
			@user.update( {gift_credit: @total_balance_update})
			logger.info "saldo de regaliux"+ String(@purchase_gift)
			@quiniela.update({purchase_gift_tickets: (Integer(@purchase_gift) + @numbers.length) })
		else
			@user.update( {balance: @total_balance_update})
		end
		
		@numbers.each_with_index do |_, i|
			QuinielaUser.create({user_id: @user.id, quiniela_id: @tira, status: 'Comprado', ticket_number: @numbers[Integer(i)], purchase_date: DateTime.now})
		end
		#BuyMailer.buy_many_tickets(@user_id, @array_values, @lottery).deliver
	
      
		
	end
	
	def get_quinielas
		@quinielas = Quiniela.all
		render :json => @quinielas		
	end
	
	def get_quinielas_no_winner	
		render :json => Quiniela.find_no_winners 		
	end
	
	def toclose
		render :json => Quiniela.toclose
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
		params.require(:quiniela).permit(:initial_balance, :price, :game_id, :description, :purchase_gift_tickets, :winner_number, quiniela_questions_attributes: [:id, :question_id, :_destroy])
    end
	
      
end
