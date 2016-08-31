class WebhooksController < ApplicationController
   skip_before_filter :verify_authenticity_token

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

     if data["type"] == "charge.succeeded" && data["transaction"]["method"] == "store" || data["transaction"]["method"] == "bank_account" 
       user_actual =  User.where("openpay_id = ?", data["transaction"]["customer_id"])
       user_actual[0].update(:balance => data["transaction"]["amount"].to_f + user_actual[0].balance) 
     end
      
   
    render nothing: true
  end
end