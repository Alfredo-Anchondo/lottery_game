class Api::V1::UserLoginController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
before_action :authenticate_user!
  def next_game
      render :json => Game.next_game
  end

  def buy_lottery
    @lottery = Lottery.find(params[:lottery_id])
    @user = User.find(params[:user_id])
    if(@user.gift_credit.to_i >= @lottery.price.to_i)
      @user.update(:gift_credit => @user.gift_credit.to_i - @lottery.price.to_i)
      @lottery.update(:initial_balance => (@lottery.price * 0.95) + @lottery.initial_balance )
      UserLottery.create(:user_id => @user.id, :lottery_id => @lottery.id, :status => "Comprado", :ticket_number => params[:ticket_number], :purchase_date => Time.now)
          render json: true
    else
      if(@user.balance.to_f >= @lottery.price.to_i)
        @user.update(:balance => @user.balance.to_f - @lottery.price.to_i)
        @lottery.update(:initial_balance => (@lottery.price * 0.95) + @lottery.initial_balance )
        UserLottery.create(:user_id => @user.id, :lottery_id => @lottery.id, :status => "Comprado", :ticket_number => params[:ticket_number], :purchase_date => Time.now)
            render json: true
      else
        render :json => { :errors => "No tienes saldo suficiente" } , :status => 422
      end
    end

  end


end
