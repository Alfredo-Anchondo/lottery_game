class PartialsController < ApplicationController
    skip_before_filter :verify_authenticity_token
	before_action :authenticate_user!, except: ['future_games', 'get_quinielas_no_winner']
	before_action "get_user"
    before_action "get_customer_credit_cars(current_user)"
    respond_to :html
  	respond_to :json

  def show
     get_customer_credit_cars(current_user)
     render "credit_card_form"
  end

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
		@update_balance = (Integer(@price)  * 0.95 )
		if @purchase_gift == '' || @purchase_gift == "NaN" || @purchase_gift == nil
			@purchase_gift = 0
		end

		render nothing: true

		if params[:normal_buy] != 'true'
			@user.update( {gift_credit: @total_balance_update})
			logger.info "saldo de regaliux" + String(@purchase_gift)
			@quiniela.update({purchase_gift_tickets: (Integer(@purchase_gift) + @numbers.length)})
			@quiniela.update({initial_balance: String(@balance.to_f + @update_balance) })
			logger.info @update_balance
		else
			@quiniela.update({initial_balance: (@balance.to_i + @update_balance.to_i)  })
			@user.update( {balance: @total_balance_update})
		end

		@numbers.each_with_index do |_, i|
			QuinielaUser.create({user_id: @user.id, quiniela_id: @tira, status: 'Comprado', ticket_number: @numbers[Integer(i)], purchase_date: DateTime.now})
		end
		#BuyMailer.buy_many_tickets(@user_id, @array_values, @lottery).deliver

	end

	  def team_logos
        @lottery = Lottery.find(params[:id])
        respond_with(:team1 => @lottery.game.team.logo_url, :team2 => @lottery.game.team2.logo_url)
    end

	def next_game
        render :json => Game.next_game
    end

	def future_games
        render :json => Game.future_games
    end

	def get_quinielas_no_winner
		render :json => Quiniela.find_no_winners.order("created_at DESC")
	end

    def get_quinielas_mainpage
        quinielas = Quiniela.where(:to_mainpage => true)
        ids = []
        quinielas.each do |quiniela|
            if quiniela.game.game_date > Time.now
                ids.push(quiniela.id)
            end
        end

		render :json =>  Quiniela.find(ids)
	end

	 def finish_games
        render :json => Game.finish_games
    end

	def get_user
		@user = current_user
	end

def create_customer()
    stablich_connection
    user_address_hash = {
      line1: current_user.address_1, line2: current_user.address_2, line3: current_user.ext_number, state: current_user.state,
      city: current_user.city, postal_code: current_user.zip_code, country_code: 'MX'
    }
    customer_hash = {name: current_user.name, last_name: current_user.last_name, email: current_user.email, requires_account: false, phone_number: current_user.phone, external_id: current_user.id , address: user_address_hash}
    customer = @customers.create(customer_hash.to_hash)
    current_user.update_attribute(:openpay_id, customer["id"]) unless customer["id"].nil?
    get_customer(customer["id"])
  return customer
rescue OpenpayTransactionException => error
    @e = error
    render 'buy_error'
end

def check_if_customer_exists_global(user)
  if user.openpay_id.nil? or user.openpay_id.blank?
    customer = create_customer
  else
    customer = get_customer(user.openpay_id)
  end
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end

 def create_credit_debit_card(customer)
  stablich_connection
  card_hash={
    token_id: params[:token_id],
    device_session_id: params[:deviceIdHiddenFieldName]
  }
  @response_hash = @cards.create(card_hash.to_hash, customer['id'])


 rescue OpenpayException => e
     @e = e
     logger.info e.description

rescue OpenpayTransactionException => error
     @e = error
     logger.info "No se registro la tarjeta de credito o debito"
     logger.info error.description
end

    def charge_with_credit_card(customer)
        stablich_connection
        request_hash={
            "method" => "card",
            "source_id" =>  params[:token_id],
            "currency" => "MXN",
            "amount" => Integer(params[:amount]) + 2.5 ,
            "description" => 'Compra de saldo en DONBILLETE',
            'device_session_id' => params[:deviceIdHiddenFieldName]
          }

        logger.info request_hash
        response_hash = @charges.create(request_hash.to_hash, customer['id'])
		porcentaje = Integer(params[:amount]) * 0.25
        current_user.update_attribute(:balance,(current_user.balance + Integer(params[:amount])))
		#current_user.update_attribute(:gift_credit, (current_user.gift_credit.to_f + porcentaje))
		BuyMailer.buy_saldo(current_user, params[:amount]).deliver
        render "complete_buy"
         rescue OpenpayException => e
         @e = e
         logger.info e.description
         render 'buy_error'

    rescue OpenpayTransactionException => e
        @e = e
        logger.info  "No se realizo el cargo a la tarjeta"
        logger.info  e.description# => 'email\' not a well-formed email address'
        render 'buy_error'
end

def get_customer(customer_id)
  stablich_connection
  customer = @customers.get(customer_id)

    if params[:store_buy]
        pay_store_ticket(customer)
    else

    if params[:bank_buy]
        pay_bank_ticket(customer)
    else

    if params[:only_register]
     create_credit_debit_card(customer)
     logger.info "SOLO SE REGISTRO LA TARJETA"
	 redirect_to :back
    else
     create_credit_debit_card(customer)
     charge_with_credit_card(customer)
    end
    end
   end


rescue OpenpayTransactionException => e
  @e = e
  logger.info   e.http_code# => 400
  logger.info  e.error_code# => 1001
  logger.info  e.description# => 'email\' not a well-formed email address'
  render 'buy_error'
end

def get_customer_credit_cars(user)
    if user == nil || user == ""
        return false
    end
    if user.openpay_id == ""
        return false
          end

  stablich_connection
  @get_cards = @cards.all(user.openpay_id)
  return @get_cards
  rescue OpenpayTransactionException => error
  logger.info error.description
rescue OpenpayConnectionException => error
	logger.info error.description
end

 def pay_store
   stablich_connection
   check_if_customer_exists_global(current_user)
 end



 def pay_store_ticket(user)

   stablich_connection
     request_hash={
     "method" => "store",
     "amount" => params[:amount],
     "description" => "Abono de saldo por medio de tienda"
   }

 response_hash=@charges.create(request_hash.to_hash,user['id'])
     render json: response_hash
 end

 def pay_bank_ticket(user)

   stablich_connection
     request_hash={
     "method" => "bank_account",
     "amount" => params[:amount],
     "description" => "Abono de saldo por medio de transferencia bancaria"
   }

 response_hash=@charges.create(request_hash.to_hash,user['id'])
     render json: response_hash
 end




def stablich_connection
  @openpay = OpenpayApi.new("m8dvprmyk9adbcmhonod", "sk_22a93d1817864bebbf99ca009358e48b") if Rails.env.development?
  @openpay = OpenpayApi.new("ml8ii2xvkgmpoxjl0aib", "sk_183c43416f464e33b5e0330cfb0e5c47", true) if Rails.env.production?
  @cards = @openpay.create(:cards)
  @bank_accounts = @openpay.create(:bankaccounts)
  @charges = @openpay.create(:charges)
  @customers = @openpay.create(:customers)
  @payouts = @openpay.create(:payouts)
rescue OpenpayTransactionException => error
    logger.info error.description
end

    def credit_card_pay
        check_if_customer_exists_global(current_user)
    end

    def dispersion
		amount = params[:quantity];
		if Integer(amount) > current_user.balance
			return 'False'
		end

       stablich_connection
        bank_account_hash={
            "holder_name" => params[:owner_name],
            "clabe" => params[:clabe],
            "currency" => "MXN"
           }

        request_hash={
             "method" => "bank_account",
             "bank_account" => bank_account_hash,
             "amount" =>  amount,
             "description" => "Pago a tercero"
           }
        logger.info "/$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$$?"
         @response_hash=@payouts.create(request_hash.to_hash)
        logger.info @response_hash['currency']
        current_user.update_attribute(:balance,(current_user.balance - Integer(params[:quantity])))
		redirect_to :root

        rescue OpenpayTransactionException => error
        @e = error
        logger.info error.description
         render 'buy_error'


           rescue OpenpayException => error
        @e = error
        logger.info error.description
        render 'buy_error'
    end



    def history
        stablich_connection
        if current_user.openpay_id
			customer = @customers.get(current_user.openpay_id)
			@user_charges = @charges.all(customer['id'])
  			logger.info @user_charges
        end
    end

	def lotteries
      @user = User.find(params[:id])
      respond_with(@user.user_lotteries)
    end

	def quinielas
      @user = User.find(params[:id])
	  respond_with(@user.quiniela_users)
    end

    @card;

    def delete_card
        stablich_connection
        @cards.delete(params['card'], params['customer'])
          redirect_to :back
          rescue OpenpayException => error
        @e = error
        logger.info "#&&&&&&&&&&&&&&&&&&&&& Se Llamo &&&&&&&&&&&&&&&&&"
        logger.info error.description

    end

	def buy_much_tickets
		render nothing: true
		@lottery = Lottery.find(params[:lottery_id])
		@lottery_price = params[:lottery_price]
		@lottery_price = Integer(@lottery_price) * Integer(params[:quantity_sale])
        @price_porcentage = @lottery_price * 0.95
        @lottery_updated_balance = @lottery.initial_balance + @price_porcentage
		@user_id = User.find(params[:user_id])
		@array_values = params[:array_values]
		logger.info @array_values
		if params[:normal_buy] != 'true'
			@user_id.update( {gift_credit: Integer(current_user.gift_credit) - @lottery_price})
			@lottery.update( {purchase_gift_tickets: Integer(@lottery.purchase_gift_tickets) + @array_values.length, initial_balance: @lottery_updated_balance})
		else
			@user_id.update( {balance: current_user.balance - @lottery_price})
            @lottery.update( {initial_balance: @lottery_updated_balance})
		end
		@array_values.each_with_index do |_, i|
		UserLottery.create({user_id: @user_id.id, lottery_id: params[:lottery_id], status: 'Comprado', ticket_number: @array_values[Integer(i)], purchase_date: DateTime.now})
		end
		#BuyMailer.buy_many_tickets(@user_id, @array_values, @lottery).deliver
	end

	def survivor_leagues
	  	@survivors = Survivor.where('extract(year  from created_at) = ?',Time.now.year).order(:id)
		@current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, 6)
	end

 #def show_category
  # @category = Category.find_by_friendly_name(params[:name])
  #end
	@current_survivor
	@current_week
	@survivor_week_sur
	@tickets_purchase
	@last_survivor_week_sur
	@last_tickets_purchase
	def set_survivor_page
		@current_survivor = Survivor.find(params[:id])
		@current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, 6)
		@survivor_week_sur = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?', params[:id],@current_week[0].id)
		@last_survivor_week_sur = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?', params[:id],(@current_week[0].id - 1))
		@tickets_purchase = SurvivorUser.where('user_id = ? AND survivor_week_survivor_id = ?', current_user.id, @survivor_week_sur[0].id)
		if @current_week[0].week == 0

			else
		@last_tickets_purchase_teams = SurvivorUser.where('user_id = ?', current_user.id)
		@last_tickets_purchase = SurvivorUser.where('user_id = ? AND survivor_week_survivor_id = ?', current_user.id, @last_survivor_week_sur[0].id)
        @games = SurvivorGame.where('survivor_week_game_id = ? and game_date < ?',@current_week[0].id, Time.now).count
		end
	end

   def top_100_enrachate
     @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now, nil).first
     if @enrachate != "" && @enrachate != [] && @enrachate != nil
       @top_100 = []
       @tickets_for_enrachate = EnrachateUser.where("enrachates_id = ?", @enrachate.id).pluck(:enrachate_user_id).uniq
       @tickets_for_enrachate.each do | ticket |
          @user_ticket = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive").first
          if @user_ticket != "" && @user_ticket != [] && @user_ticket != nil
          @top_100.push(@user_ticket)
        end
       end
     end
   end

   def enrachate_survivor_history
         @enrachate = Enrachate.where("type_enrachate = ? and id = ? and winner IS ?",1,params[:id],nil).first
         @tickets = EnrachateUser.where(" enrachates_id = ?", @enrachate.id)
   end

   def enrachates_survivor
       @enrachates = Enrachate.where("type_enrachate = ?  and winner IS ?",1,nil)
   end

    def enrachate
        @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now,nil).first
        if @enrachate != "" && @enrachate != [] && @enrachate != nil

        @current_tira = @enrachate.current_tira
        @last_tira = @enrachate.past_tira
        @future_tira = @enrachate.future_tira
        @tickets_for_enrachate = EnrachateUser.where("enrachates_id = ?", @enrachate.id).pluck(:enrachate_user_id).uniq
        @racha_values = []
         @tickets_for_enrachate.each do | ticket |
           @tickets_s = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive")
           @count_ticket = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive").count
           last =  @tickets_s.where("tira_enrachate_id = ?", @last_tira.id).count
           current =  @tickets_s.where("tira_enrachate_id = ?", @current_tira.id).count
           if last != 0 || current != 0
           @racha_values.push(@count_ticket)
           end
         end
        @lose_count =  EnrachateUser.where("user_id = ? and enrachates_id = ? and status = ?",current_user.id, @enrachate.id, "loser").count
        @alive_count =  EnrachateUser.where("user_id = ? and enrachates_id = ? and status = ?",current_user.id, @enrachate.id, "alive").count
        @recent_buy_ticket_enrachate = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ? and status != ? ", current_user.id, @enrachate.id, @current_tira.id, "loser" ).last
        if   @last_tira != ""
          @last_day_ticket = EnrachateUser.where("user_id = ? and status = ? and enrachates_id = ? and tira_enrachate_id = ? ", current_user.id, "alive", @enrachate.id, @last_tira.id ).last
        end
        @can_change_question = true

        if @recent_buy_ticket_enrachate != "" && @recent_buy_ticket_enrachate != [] && @recent_buy_ticket_enrachate != nil
            logger.info "Entre A DONDE NO DEBERIA U________U"
            logger.info @recent_buy_ticket_enrachate.id
            @already_select_question = @recent_buy_ticket_enrachate.answer != nil  ? true : false
            @can_select_next = @recent_buy_ticket_enrachate.status == "alive" ? true : false
                if @recent_buy_ticket_enrachate.question_enrachate != "" && @recent_buy_ticket_enrachate.question_enrachate != [] && @recent_buy_ticket_enrachate.question_enrachate != nil
            @can_change_question = @recent_buy_ticket_enrachate.question_enrachate.program_date < Time.now ? false : true
                end
            @enrachate_user_id = @recent_buy_ticket_enrachate.enrachate_user_id
                if @future_tira != "" && @future_tira != [] && @future_tira != nil
                     @future_ticket =  EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ?",current_user.id,@enrachate.id,@future_tira.id).first
                     @future_tira_ticket = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ?",current_user.id,@enrachate.id,@future_tira.id).count != 0 ? true : false
                end
        end

        if @last_day_ticket != "" && @last_day_ticket != [] && @last_day_ticket != nil
             @enrachate_user_id = @last_day_ticket.enrachate_user_id
        end

             logger.info @can_change_question
        logger.info "Se puede cambiar la respuesta????????????????"
      else
      end
    end

    def my_ticket_history
      @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now,nil).first
      @tickets = EnrachateUser.where("user_id = ? and enrachates_id = ?", current_user.id, @enrachate.id)
    end

    def my_enrachate_leagues
      @enrachates_id = EnrachateUser.where("user_id = ?", current_user.id ).pluck(:enrachates_id).uniq
      @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now, nil).first
      @current_tira = @enrachate.current_tira
      @last_ticket = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ?", current_user.id, @enrachate.id,@current_tira.id ).last
    end

    def enrachate_survivor
      @enrachate = Enrachate.where("type_enrachate = ? and id = ? and winner IS ?",1,params[:id],nil).first
      if @enrachate != "" && @enrachate != [] && @enrachate != nil

      @current_tira = @enrachate.current_tira
      @last_tira = @enrachate.past_tira
      @future_tira = @enrachate.future_tira
      @tickets_for_enrachate = EnrachateUser.where("enrachates_id = ?", @enrachate.id).pluck(:enrachate_user_id).uniq
      @racha_values = []
       @tickets_for_enrachate.each do | ticket |
         @count_ticket = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive").count
         @racha_values.push(@count_ticket)
       end
      @lose_count =  EnrachateUser.where("user_id = ? and enrachates_id = ? and status = ?",current_user.id, @enrachate.id, "loser").count
      @alive_count =  EnrachateUser.where("user_id = ? and enrachates_id = ? and status = ?",current_user.id, @enrachate.id, "alive").count
      @recent_buy_ticket_enrachate = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ? and status != ? ", current_user.id, @enrachate.id, @current_tira.id, "loser" ).last
      if   @last_tira != ""
        @last_day_ticket = EnrachateUser.where("user_id = ? and status = ? and enrachates_id = ? and tira_enrachate_id = ? ", current_user.id, "alive", @enrachate.id, @last_tira.id ).last
        @last_ticket_users = EnrachateUser.where(" status = ? and enrachates_id = ? and tira_enrachate_id = ? ",  "alive", @enrachate.id, @last_tira.id )
      end
      @can_change_question = true

      if @recent_buy_ticket_enrachate != "" && @recent_buy_ticket_enrachate != [] && @recent_buy_ticket_enrachate != nil
          logger.info "Entre A DONDE NO DEBERIA U________U"
          logger.info @recent_buy_ticket_enrachate.id
          @already_select_question = @recent_buy_ticket_enrachate.answer != nil  ? true : false
          @can_select_next = @recent_buy_ticket_enrachate.status == "alive" ? true : false
              if @recent_buy_ticket_enrachate.question_enrachate != "" && @recent_buy_ticket_enrachate.question_enrachate != [] && @recent_buy_ticket_enrachate.question_enrachate != nil
          @can_change_question = @recent_buy_ticket_enrachate.question_enrachate.program_date < Time.now ? false : true
              end
          @enrachate_user_id = @recent_buy_ticket_enrachate.enrachate_user_id
              if @future_tira != "" && @future_tira != [] && @future_tira != nil
                   @future_ticket =  EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ?",current_user.id,@enrachate.id,@future_tira.id).first
                   @future_tira_ticket = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ?",current_user.id,@enrachate.id,@future_tira.id).count != 0 ? true : false
              end
      end

      if @last_day_ticket != "" && @last_day_ticket != [] && @last_day_ticket != nil
           @enrachate_user_id = @last_day_ticket.enrachate_user_id
      end

           logger.info @can_change_question
      logger.info "Se puede cambiar la respuesta????????????????"
    else
    end
    end


    def enrachate_history
        @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now,nil).first
        @current_tira = @enrachate.current_tira
        @last_tira = @enrachate.past_tira
        @future_tira = @enrachate.future_tira
        @recent_buy_ticket_enrachate = EnrachateUser.where("user_id = ? and enrachates_id = ? and tira_enrachate_id = ? and status != ? ", current_user.id, @enrachate.id, @current_tira.id, "loser" ).last
          if @last_tira != nil && @last_tira != "" && @last_tira != []
           @last_day_ticket = EnrachateUser.where("user_id = ? and status = ? and enrachates_id = ? and tira_enrachate_id = ? ", current_user.id, "alive", @enrachate.id, @last_tira.id ).last
          end
        @ticket_alive = @recent_buy_ticket_enrachate != "" && @recent_buy_ticket_enrachate != nil && @recent_buy_ticket_enrachate != [] ? @recent_buy_ticket_enrachate : @last_day_ticket
        if   @ticket_alive != "" &&   @ticket_alive != nil &&   @ticket_alive != []
        @tickets = EnrachateUser.where("enrachate_user_id = ?", @ticket_alive.enrachate_user_id )
      else
       @tickets = []
     end
    end


    def change_score
        ticket = PickUser.find(params[:id])
        ticket.update(:local_score => params[:local_score] , :visit_score => params[:visit_score])
        	render json: true
    end

    def select_week_1
		@current_survivor = Survivor.find(params[:id])
		@current_week = SurvivorWeekGame.where('week = ? AND sport_category = ?', 3, 6)
		@survivor_week_sur = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?', params[:id],@current_week[0].id)
		@last_survivor_week_sur = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?', params[:id],(@current_week[0].id - 1))
		@tickets_purchase = SurvivorUser.where('user_id = ? AND survivor_week_survivor_id = ?', current_user.id, @survivor_week_sur[0].id)
		if @current_week[0].week == 0

			else
		@last_tickets_purchase_teams = SurvivorUser.where('user_id = ?', current_user.id)
		@last_tickets_purchase = SurvivorUser.where('user_id = ? AND survivor_week_survivor_id = ?', current_user.id, @last_survivor_week_sur[0].id)
        @games = SurvivorGame.where('survivor_week_game_id = ? and game_date < ?',@current_week[0].id, Time.now).count
		end
	end

	def close_quinielas
		render :json =>	Quiniela.where('winner_number != ? ', '').order(id: :desc).first(10)
	end


    def delete_ticket
        render :nothing => true
        last_tickets_purchase = SurvivorUser.where(:id => params[:last_tickets_purchase])
        entry = SurvivorUser.where('id = ?',params[:entry])
        logger.info params[:tickets_purchase]
        tickets_purchase = SurvivorUser.where(:id => params[:tickets_purchase])
         logger.info entry[0]
        logger.info last_tickets_purchase
         logger.info "///////////////////"

         last_ticket = last_tickets_purchase.where('survivor_user_id = ? and status = ?',entry[0].survivor_user_id,'loser').exists?
             if last_ticket == true
                last_tickets_purchase.where('survivor_user_id = ? and status = ?',entry[0].survivor_user_id,'loser').first.update(:status => 'alreadyrebuy')
             else
             end
                tickets_purchase.where('survivor_user_id = ?',entry[0].survivor_user_id).first().delete()
        return true
    end

	 @survivor_id
	 @survivor_create

	def my_leagues
		tickets = SurvivorUser.where('user_id = ?',current_user.id).pluck(:survivor_week_survivor_id).uniq()
		survivor_user_survivor = SurvivorWeekSurvivor.where(:id => tickets).pluck(:survivor_id).uniq()
		@survivor_id = Survivor.where(:id => survivor_user_survivor)
		@survivor_create = Survivor.where(:user_id => current_user.id)
		@current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, 6)
	end


	def survivor_history
      @current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, 6)
      @survivor_week_sur = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?', params[:id],@current_week[0].id)
      @buy_ticket_already = SurvivorUser.where('survivor_week_survivor_id = ? and user_id = ?', @survivor_week_sur[0].id, current_user.id )
	  @usuarios = {}
	  @survivor = Survivor.find(params[:id])
	  @survivorweeksurvivor = SurvivorWeekSurvivor.where(:survivor_id => params[:id]).pluck(:id)
	  @survivoruser = SurvivorUser.where(:survivor_week_survivor_id => @survivorweeksurvivor).order(:id)
		@survivoruser.each do |user|
		@usuarios[user.user.username]= {}
		end
		@survivoruser.each do |user|
			@usuarios[user.user.username][user.survivor_user_id] = {}
		end
		@survivoruser.each do |user|
            if user.survivor_week_survivor_id == @survivor_week_sur[0].id
                teamid = user.team ? user.team.id : 'No tiene equipo'
            if teamid == 'No tiene equipo'
            else
                game = SurvivorGame.where('survivor_week_game_id = ? and team_id = ?',@current_week[0].id, teamid)
                if game != [] && game != '' && game != nil
                    logger.info game[0].team.name
                    logger.info '////////////&&&&&&&&&&&&&&&///////////'
                   pendint = game[0].game_date > Time.new ? 'Juegopendiente' : 'Juegoterminado'
                    logger.info pendint
                else
                  game = SurvivorGame.where('survivor_week_game_id = ? and team2_id = ?',@current_week[0].id, teamid)
                    logger.info game[0].team.name
                    logger.info '////////////&&&&&&&&&&&&&&&///////////'
                   pendint = game[0].game_date > Time.new ? 'Juegopendiente' : 'Juegoterminado'
                    logger.info pendint
                end
            end
            else
            end

			@usuarios[user.user.username][user.survivor_user_id][user.survivor_week_survivor.survivor_week_game.week.to_s] = {:team => user.team, :status => user.status, :game => pendint }
			logger.info @usuarios
		end
	end

    def pickem_week_games_history
        @pickem = Pick.find(params[:id])
        @current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, @pickem.sport_category_id)
        @weeks = @pickem.survivor_week_games

    end


	def access_request_mail
		render :nothing => true
		owner = User.find(params[:owner])
		survivor = Survivor.find(params[:survivor])
		BuyMailer.access_request_mail(current_user,owner,survivor).deliver
	end

    def access_request_mail_pick
		render :nothing => true
		owner = User.find(params[:owner])
		survivor = Pick.find(params[:survivor])
		BuyMailer.access_request_mail_pick(current_user,owner,survivor).deliver
	end




	def invite_friends_survivor
		@survivor = Survivor.find(params[:id])
	end

    def invite_friends_pick
        @survivor = Pick.find(params[:id])
    end

	def inviting
		render nothing: true
		@mails = params['mails']
		@reference = params['reference']
		@user = current_user
		BuyMailer.invite(@mails, @reference, @user).deliver

	end

	def invite_survivor
		render nothing: true
		@mails = params['mails']
		@survivor = Survivor.find(params['survivor_id'])
		@user = current_user
		BuyMailer.invite_survivor(@mails, @survivor, @user).deliver
	end

    def invite_pick
		render nothing: true
		@mails = params['mails']
		@survivor = Pick.find(params['survivor_id'])
		@user = current_user
		BuyMailer.invite_pick(@mails, @survivor, @user).deliver
	end

	def pickem_leagues
		@picks = Pick.where('extract(year from created_at) = ?',Time.now.year).order(:id)
		@categories = Pick.where('extract(year from created_at) = ?',Time.now.year).order(:sport_category_id).pluck(:sport_category_id).uniq
		@current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ?', Time.now, Time.now)
	end

	def pickem
		@pick = Pick.find(params[:id])
		@current_week = SurvivorWeekGame.where('initial_date <= ? AND final_date >= ? AND sport_category = ?', Time.now, Time.now, @pick.sport_category_id)
		@PickSurvivorWeek = PickSurvivorWeek.where(:pick_id => params[:id]).order(:id).pluck(:id)
        @current_pick_survivor_week = PickSurvivorWeek.where('pick_id = ? AND survivor_week_game_id = ?',params[:id],@current_week[0].id)
		@tickets_purchase = PickUser.where('user_id = ? AND pick_survivor_week_id = ?', current_user.id, @PickSurvivorWeek[0])
        @current_tickets_purchase = PickUser.where('user_id = ? AND pick_survivor_week_id = ?', current_user.id, @current_pick_survivor_week[0].id).pluck(:pick_user_id)
		@games = SurvivorGame.where('survivor_week_game_id = ?',@current_week[0].id).order(:game_date)
	end

    def select_pick_1
		@pick = Pick.find(params[:id])
		@current_week = SurvivorWeekGame.where('week = ? AND sport_category = ?',1, @pick.sport_category_id)
		@PickSurvivorWeek = PickSurvivorWeek.where(:pick_id => params[:id]).order(:id).pluck(:id)
        @current_pick_survivor_week = PickSurvivorWeek.where('pick_id = ? AND survivor_week_game_id = ?',params[:id],@current_week[0].id)
		@tickets_purchase = PickUser.where('user_id = ? AND pick_survivor_week_id = ?', current_user.id, @PickSurvivorWeek[0])
        @current_tickets_purchase = PickUser.where('user_id = ? AND pick_survivor_week_id = ?', current_user.id, @current_pick_survivor_week[0].id).pluck(:pick_user_id)
		@games = SurvivorGame.where('survivor_week_game_id = ?',@current_week[0].id).order(:game_date)
	end

    def change_pick_team
        ticket = PickUserGame.find(params[:ticket_id])
        team_id = params[:team_id]
        ticket.update(:team_id => team_id)
        	render json: true
    end

	def my_pickem_leagues
		tickets = PickUser.where('user_id = ?',current_user.id).pluck(:pick_survivor_week_id).uniq()
		survivor_user_survivor = PickSurvivorWeek.where(:id => tickets).pluck(:pick_id).uniq()
		@survivor_id = Pick.where(:id => survivor_user_survivor)
		@survivor_create = Pick.where(:user_id => current_user.id)
		@current_week = PickSurvivorWeek.where('initial_date <= ? AND final_date >= ? ', Time.now, Time.now)
	end

      def get_weeks
        render :json => SurvivorWeekGame.current_year.where('sport_category = ?', params[:category]).count
    end


    def pick_history
	  @usuarios = {}
	  @pick = Pick.find(params[:id])
	  @picksurvivorweek = PickSurvivorWeek.where(:pick_id => params[:id]).pluck(:id)
	  @pickuser = PickUser.where(:pick_survivor_week_id => @picksurvivorweek).order(:id)
		@pickuser.each do |user|
		@usuarios[user.user.username]= {}
		end
		@pickuser.each do |user|
			@usuarios[user.user.username][user.pick_user_id] = {}
		end
		@pickuser.each do |user|
			@usuarios[user.user.username][user.pick_user_id][user.pick_survivor_week.survivor_week_game.week.to_s] = {:points => user.points, :status => user.status }
			logger.info @usuarios
		end
	end

    def response_request
        logger.info params[:response]
        @request = User.find(params[:id_request])
        @owner = User.find(params[:id_owner])
        @survivor = Survivor.find(params[:survivor])
        @response = params[:response]
        if params[:response] == 'true'
            @respuesta = 'Se le concedio al usuario el acceso correctamente'
            @respuesta2 = 'El usuario ya fue notificado por correo.'
            BuyMailer.response_access(@request, @owner, @survivor, @response).deliver
            else
            @respuesta = 'El acceso fue denegado para el usuario'
            @respuesta2 = 'El usuario ya fue notificado por correo'
            BuyMailer.response_access(@request, @owner, @survivor, @response).deliver
        end
    end

     def response_access_pick
        logger.info params[:response]
        @request = User.find(params[:id_request])
        @owner = User.find(params[:id_owner])
        @survivor = Pick.find(params[:survivor])
        @response = params[:response]
        if params[:response] == 'true'
            @respuesta = 'Se le concedio al usuario el acceso correctamente'
            @respuesta2 = 'El usuario ya fue notificado por correo.'
            BuyMailer.response_access_pick(@request, @owner, @survivor, @response).deliver
            else
            @respuesta = 'El acceso fue denegado para el usuario'
            @respuesta2 = 'El usuario ya fue notificado por correo'
            BuyMailer.response_access_pick(@request, @owner, @survivor, @response).deliver
        end
    end




end
