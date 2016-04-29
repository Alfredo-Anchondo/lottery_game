class UserLotteriesController < ApplicationController
  before_action :set_user_lottery, only: [:show, :edit, :update, :destroy]
  before_action :data, only: [:index, :new, :create, :edit, :update]
  # GET /user_lotteries
  # GET /user_lotteries.json
  respond_to :html
  respond_to :json
	
  def search_ticket_by_lottery
	 render :json => UserLottery.search_ticket_by_lottery(params[:id])
  end
	
  def index
    @user_lotteries = UserLottery.all
  end

  # GET /user_lotteries/1
  # GET /user_lotteries/1.json
  def show
  end

  # GET /user_lotteries/new
  def new
    @user_lottery = UserLottery.new
  end

    def winners_total
        render :json => UserLottery.winners_total
    end
    
	def buy_much_tickets		
		logger.info "entramos"
		logger.info params
		render nothing: true
		@user_id = User.find(params[:user_id])
		@array_values = params[:array_values]
		
		@array_values.each do |variable|
			logger.info @user_id.id
			create_cycle(@user_id.id, params[:lottery_id], 'Comprado',@array_values[Integer(variable)], DateTime.now )
		end
		
	end
	
	

    
  # GET /user_lotteries/1/edit
  def edit
  end
	
  # POST /user_lotteries
  # POST /user_lotteries.json
  def create
    
    @user_lottery = UserLottery.new(user_lottery_params)

    respond_to do |format|
      if @user_lottery.save
        BuyMailer.buy_ticket(@user_lottery.user, @user_lottery.lottery, @user_lottery).deliver
        format.html { redirect_to @user_lottery, notice: 'User lottery was successfully created.' }
        format.json { render :show, status: :created, location: @user_lottery } 
      else
        format.html { render :new }
        format.json { render json: @user_lottery.errors, status: :unprocessable_entity }
      end
    end
  end

    def winners
        render :json => UserLottery.winners
    end
    
  # PATCH/PUT /user_lotteries/1
  # PATCH/PUT /user_lotteries/1.json
  def update
    respond_to do |format|
      if @user_lottery.update(user_lottery_params)
          format.html { redirect_to @user_lottery, notice: t('success_update_user_lotteries') }
        format.json { render :show, status: :ok, location: @user_lottery }
      else
        format.html { render :edit }
        format.json { render json: @user_lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_lotteries/1
  # DELETE /user_lotteries/1.json
  def destroy
    @user_lottery.destroy
    respond_to do |format|
      format.html { redirect_to user_lotteries_url, notice: 'User lottery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_lottery
      @user_lottery = UserLottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_lottery_params
      params.require(:user_lottery).permit(:user_id, :lottery_id, :status, :ticket_number, :purchase_date)
    end
end
