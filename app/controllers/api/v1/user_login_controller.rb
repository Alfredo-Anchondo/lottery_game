class Api::V1::UserLoginController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
before_action :authenticate_user!
  def next_game
      render :json => Game.next_game
  end

  def buy_lottery
    UserLottery.create(:user_id => params[:user_id], :lottery_id => params[:lottery_id], :status => "Comprado", :ticket_number => params[:ticket_number], :purchase_date => Time.now)
    render json: true
  end


end
