class WebhooksController < ApplicationController
   skip_before_filter :verify_authenticity_token

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end
      logger.info data

     if data["type"] == "charge.succeeded" && data["transaction"]["method"] == "store" || data["transaction"]["method"] == "bank_account"
       if data["type"] == "payout.succeeded"
       else
         if data["type"] == "payout.created"
         else

       user_actual =  User.where("openpay_id = ?", data["transaction"]["customer_id"])
       logger.info user_actual[0]
       user_actual[0].update(:balance => data["transaction"]["amount"].to_f + user_actual[0].balance)
     end
     end
   end


    render nothing: true
  end
end
