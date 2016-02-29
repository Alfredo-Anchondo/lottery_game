class LotteriesController < ApplicationController
  before_action :set_lottery, only: [:show, :edit, :update, :destroy]
  before_action :data, only: [:index, :new, :create, :edit, :update]

  respond_to :html
  respond_to :json

  def index
    @lotteries = Lottery.all
    respond_with(@lotteries)
  end

  def show
    respond_with(@lottery)
  end
    
    def day_lottery
        params[:game_id]
        render :json => Lottery.day_lottery 
    end

  def new
    @lottery = Lottery.new
    respond_with(@lottery)
  end

  def edit
  end

  def create
    @lottery = Lottery.new(lottery_params)
    @lottery.save
    respond_with(@lottery)
  end

  def update
       respond_to do |format|
           if @lottery.update(lottery_params)
               format.html { redirect_to @lottery, notice: t('success_update_lottery') }
               format.json { render :show, status: :ok, location: @lottery }
      else
        format.html { render :edit }
               format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lottery.destroy
    respond_with(@lottery)
  end

  private
    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    def lottery_params
      params.require(:lottery).permit(:initial_balance, :rules, :description, :game_id, :winner_number, :initial_number, :final_number, :price)
    end
end
