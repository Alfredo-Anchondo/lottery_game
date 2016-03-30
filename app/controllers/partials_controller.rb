class PartialsController < ApplicationController
    skip_before_filter :verify_authenticity_token  
    
  def show
     render "credit_card_form"  
  end
    
def create_customer()
  user_address_hash = {
      line1: "#{current_user.address1} #{current_user.external_number}", line2: current_user.address2, line3: current_user.int_number, state: current_user.state,
      city: current_user.city, postal_code: current_user.zipcode, country_code: 'MX'
  }  
    customer_hash = {name: current_user.first_name, last_name: current_user.last_name, email: current_user.email, requires_account: false, phone_number: current_user.phone, address: user_address_hash}    
  customer = @customers.create(customer_hash.to_hash)
  #user.update_attribute(:openpay_id, customer["id"]) unless customer["id"].nil?
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
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
  error_details(error)
end
    
    def credit_card_pay
        #stablich_connection
        #@openpay=OpenpayApi.new("m8dvprmyk9adbcmhonod","sk_22a93d1817864bebbf99ca009358e48b")
        #@charges=@openpay.create(:charges)
        #request_hash={
         #   "method" => "card",
        #    "source_id" =>  params[:token_id],
        #    "amount" => 20,
        #    "description" => 'description',
        #    'device_session_id' => params[:deviceIdHiddenFieldName]
        #  }
        
    #    logger.info request_hash
        
     #   begin
    # response_hash = @charges.create(request_hash.to_hash)
#rescue OpenpayTransactionException => e
 # logger.info   e.http_code# => 400
  #logger.info  e.error_code# => 1001
  #logger.info  e.description# => 'email\' not a well-formed email address'
#end
       
        render "credit_card_form"  

    end
    
        
    
end