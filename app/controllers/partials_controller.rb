class PartialsController < ApplicationController
    skip_before_filter :verify_authenticity_token
	before_action :authenticate_user!, except: ['future_games', 'get_quinielas_no_winner']
	before_action "get_user"
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

	  def team_logos
        @lottery = Lottery.find(params[:id])
        respond_with(:team1 => @lottery.game.team, :team2 => @lottery.game.team2)
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
		porcentaje = Integer(params[:amount]) * 0.20
        current_user.update_attribute(:balance,(current_user.balance + Integer(params[:amount])))
		current_user.update_attribute(:gift_credit, (current_user.gift_credit + porcentaje))
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

    if params[:only_register]
     create_credit_debit_card(customer)
     logger.info "SOLO SE REGISTRO LA TARJETA"
	 redirect_to :back
    else
     create_credit_debit_card(customer)
     charge_with_credit_card(customer)
    end

rescue OpenpayTransactionException => e
  @e = e
  logger.info   e.http_code# => 400
  logger.info  e.error_code# => 1001
  logger.info  e.description# => 'email\' not a well-formed email address'
  render 'buy_error'
end

def get_customer_credit_cars(user)
  logger.info "//////////////////////////////////////Hello////////////////////////////"
  stablich_connection
  logger.info @cards.all(user.openpay_id)
  @get_cards = @cards.all(user.openpay_id)
  return @get_cards
  rescue OpenpayTransactionException => error
  logger.info error.description
rescue OpenpayConnectionException => error
	logger.info error.description
end

def stablich_connection
  @openpay = OpenpayApi.new("ml8ii2xvkgmpoxjl0aib", "sk_183c43416f464e33b5e0330cfb0e5c47") if Rails.env.development?
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
		logger.info "entramos"
		logger.info params
		render nothing: true
		@lottery = Lottery.find(params[:lottery_id])
		@lottery_price = params[:lottery_price]
		@lottery_price = Integer(@lottery_price) * Integer(params[:quantity_sale])
		@user_id = User.find(params[:user_id])
		@array_values = params[:array_values]
		logger.info @array_values
		if params[:normal_buy] != 'true'
			@user_id.update( {gift_credit: Integer(current_user.gift_credit) - @lottery_price})
			@lottery.update( {purchase_gift_tickets: Integer(@lottery.purchase_gift_tickets) + @array_values.length})
		else
			@user_id.update( {balance: current_user.balance - @lottery_price})
		end
		@array_values.each_with_index do |_, i|
		UserLottery.create({user_id: @user_id.id, lottery_id: params[:lottery_id], status: 'Comprado', ticket_number: @array_values[Integer(i)], purchase_date: DateTime.now})
		end
		#BuyMailer.buy_many_tickets(@user_id, @array_values, @lottery).deliver
	end
	
	def get_survivor
	  	render :json =>	Survivor.where('extract(year  from created_at) = ?',Time.now.year)
		logger.info 'aqui se hizo //////////////'
	end

 #def show_category
  # @category = Category.find_by_friendly_name(params[:name])
  #end
end
