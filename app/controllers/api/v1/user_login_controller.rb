class Api::V1::UserLoginController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
before_action :authenticate_user!
  def next_game
      render :json => Game.next_game
  end

def enrachate_25
  @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ? and price != ?",0,Time.now,Time.now,nil,0).first
  render :json => @enrachate.to_json(:only => ["name","price","initial_balance"])
end

def create_enrachate_25_ticket
  @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ? and price != ?",0,Time.now,Time.now,nil,0).first
   if params[:already_buy] != nil && params[:already_buy] != "" && params[:already_buy] != {}
     EnrachateUser.find(params[:already_buy]).update(:question_enrachate_id => params[:question_id], :answer => params[:answer] )
   else
     EnrachateUser.create(:question_enrachate_id => params[:question_id] , :tira_enrachate_id => params[:tira_id] , :answer => params[:answer], :user_id => params[:user_id], :status => "bought", :purchase_date => Time.now, :enrachate_user_id => "", :enrachates_id => @enrachate.id)
     render json: true
   end

end

def enrachate_25_questions
  @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ? and price != ?",0,Time.now,Time.now,nil,0).first
  @current_tira = @enrachate.current_tira
  @last_tira = @enrachate.past_tira
  @future_tira = @enrachate.future_tira
  @already_buy_ticket = EnrachateUser.where("enrachates_id = ? and tira_enrachate_id = ? and user_id = ?", @enrachate.id, @current_tira.id, current_user.id).first
  render json: [@current_tira, @last_tira, @future_tira, @already_buy_ticket ]
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
