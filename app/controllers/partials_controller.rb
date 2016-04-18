class PartialsController < ApplicationController
    skip_before_filter :verify_authenticity_token  
    before_action :authenticate_user!
    
  def show
     get_customer_credit_cars(current_user)  
     render "credit_card_form"     
  end
    
def create_customer()
    stablich_connection
    user_address_hash = {
      line1: "#{current_user.address_1} #{current_user.ext_number}", line2: current_user.address_2, line3: current_user.int_number, state: current_user.state,
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
            "currency" => "USD",
            "amount" => Integer(params[:amount]) + 0.15 ,
            "description" => 'Compra de saldo en DONBILLETE',
            'device_session_id' => params[:deviceIdHiddenFieldName]
          }
        
        logger.info request_hash
        response_hash = @charges.create(request_hash.to_hash, customer['id'])
        current_user.update_attribute(:balance,(current_user.balance + Integer(params[:amount]))) 
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
end    
    
def stablich_connection
  @openpay = OpenpayApi.new('m8dvprmyk9adbcmhonod', "sk_22a93d1817864bebbf99ca009358e48b") if Rails.env.development?
  @openpay = OpenpayApi.new('m8dvprmyk9adbcmhonod', "sk_22a93d1817864bebbf99ca009358e48b", ENV['OPENPAY_PRODUCTION']) if Rails.env.production?
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
       stablich_connection
        bank_account_hash={
            "holder_name" => params[:owner_name],
            "clabe" => params[:clabe],
            "currency" => "USD"
           }
        
         amount = Integer(params[:quantity]) * Float(params[:conversion]);
        request_hash={
             "method" => "bank_account",
             "bank_account" => bank_account_hash,
            "amount" =>  amount.round(2),
             "description" => "Pago a tercero"
           }
        logger.info "/$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$?$$?"
         @response_hash=@payouts.create(request_hash.to_hash)
        logger.info @response_hash['currency']
        current_user.update_attribute(:balance,(current_user.balance - Integer(params[:quantity])))
        render :template => 'welcome/index'
        
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
  @user_charges = @charges.all(customer["id"])    
  logger.info @user_charges       
        end
        
    end
    
    def return_card_id
        return params['card']
    end
    
    
    private
    def delete_card(card, customer)
        stablich_connection
        @cards.delete(card_id, customer_id)
    end
    
    helper_method :delete_card
        
    
end