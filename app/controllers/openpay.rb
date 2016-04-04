def stablich_connection
  @openpay = OpenpayApi.new(ENV['OPENPAY_MERCHANT_ID'], ENV['OPENPAY_PRIVATE_KEY']) if Rails.env.development?
  @openpay = OpenpayApi.new(ENV['OPENPAY_MERCHANT_ID'], ENV['OPENPAY_PRIVATE_KEY'], ENV['OPENPAY_PRODUCTION']) if Rails.env.production?
  @cards = @openpay.create(:cards)
  @bank_accounts = @openpay.create(:bankaccounts)
  @charges = @openpay.create(:charges)

  @payouts = @openpay.create(:payouts)
rescue OpenpayTransactionException => error
  error_details(error)
end

def make_dispersion
  stablich_connection
  @customer = check_if_customer_exists_global(@seller)
  request_hash = {
    method: "bank_account",
    destination_id: @seller.withdraw_item_id,   
    amount: @charge.invoice.seller_commissions,
    description: @charge.description,
    order_id: @charge.order_id +  rand(0..1000).to_s
  }
  @response_hash = @payouts.create(request_hash.to_hash, @customer['id'])
rescue OpenpayException => error
  error_details(error)
end

def make_payment
  stablich_connection
  @invalid = false
  @customer = check_if_customer_exists(@charge.invoice.buyer, @charge.invoice)
  if @invoice.payment_type.payment_code == 'TC' or @invoice.payment_type.payment_code == 'TD'
    credit_debit_card_payment
  elsif @invoice.payment_type.payment_code == 'TB'
    bank_transfer_payment
  elsif @invoice.payment_type.payment_code == 'PE'
    cash_payment
  end
  return @response_hash
rescue OpenpayTransactionException => error
  error_details(error)
end


def credit_debit_card_payment
  include_charges = @charge.invoice.invoices_add_ons.any? ? ' + extras' : ''
  @description =  "Compra en Bolettos.com (TC/TD) - #{@charge.invoice.invoice_tickets.first.ticket.publication.event.title} (x#{@charge.invoice.invoice_tickets.count} boletos #{include_charges}) - #{I18n.l @charge.invoice.invoice_tickets.first.ticket.publication.event_date.date, format: :default}"

  request_hash={
    method: "card",
    source_id: @token_id,
    amount: @charge.invoice.buyer_spending,
    currency: "MXN",
    description: @description,
    order_id: @charge.invoice.custom_id,
    device_session_id: @device_session_id,
  }

  @response_hash = @charges.create(request_hash.to_hash, @customer['id'])
  @charge.update_attributes(openpay_id: @response_hash['id'], customer_id: @charge.invoice.buyer.openpay_id.to_s, 
    payment_method: @response_hash['card']['type'], payment_method_id: @response_hash['card']['id'], order_id: @charge.invoice.custom_id + @charge.invoice.tickets_number.to_s,  
    payment_method_number: @response_hash['card']['card_number'], authorization: @response_hash['authorization'], bank: @response_hash['card']['bank_name'], description: @description,
    status: @response_hash['status'], custom_id: "C#{@charge.id.to_s}I#{@charge.invoice_id.to_s}P#{@charge.invoice.tickets.first.publication_id.to_s}U#{@charge.invoice.buyer_id.to_s}#{truncate(@charge.invoice.tickets.first.publication.event.title.gsub(' ', '').upcase, length: 8, omission: '')}")
rescue OpenpayTransactionException => error
  error_details(error)
end

def bank_transfer_payment
  include_charges = @charge.invoice.invoices_add_ons.any? ? ' + extras' : ''
  @description =  "Compra en Bolettos.com (Banco) - #{@charge.invoice.invoice_tickets.first.ticket.publication.event.title} (x#{@charge.invoice.invoice_tickets.count} boletos #{include_charges}) - #{I18n.l @charge.invoice.invoice_tickets.first.ticket.publication.event_date.date, format: :default}"
  request_hash={
    method: "bank_account",
    amount: @charge.invoice.buyer_spending,
    description: @description,
    order_id: @charge.invoice.custom_id,
    due_date: (Time.now + 6.hours).to_time.iso8601
  }  
  @response_hash = @charges.create(request_hash.to_hash, @customer['id'])
  @charge.update_attributes(openpay_id: @response_hash['id'], customer_id: @response_hash['customer_id'], order_id: @charge.invoice.custom_id + @charge.invoice.tickets_number.to_s, 
    payment_method: @response_hash['payment_method']['type'], payment_method_id: @response_hash['payment_method']['clabe'], 
    payment_method_number: @response_hash['payment_method']['clabe'], authorization: @response_hash['authorization'], 
    description: @description, concept_number: @response_hash['payment_method']['name'], reference_number: @response_hash['payment_method']['name'], 
    bank: @response_hash['payment_method']['bank'], status: @response_hash['status'], custom_id: "C#{@charge.id.to_s}I#{@charge.invoice_id.to_s}P#{@charge.invoice.tickets.first.publication_id.to_s}U#{@charge.invoice.buyer_id.to_s}#{truncate(@charge.invoice.tickets.first.publication.event.title.gsub(' ', '').upcase, length: 8, omission: '')}")
rescue OpenpayTransactionException => error
  error_details(error)
end 

def cash_payment
  include_charges = @charge.invoice.invoices_add_ons.any? ? ' + extras' : ''
  @description =  "Compra en Bolettos.com (Tienda) - #{@charge.invoice.invoice_tickets.first.ticket.publication.event.title} (x#{@charge.invoice.invoice_tickets.count} boletos #{include_charges}) - #{I18n.l @charge.invoice.invoice_tickets.first.ticket.publication.event_date.date, format: :default}"
  request_hash={
    method: "store",
    amount: @charge.invoice.buyer_spending,
    description: @description,
    order_id: @charge.invoice.custom_id,
    due_date: (Time.now + 6.hours).to_time.iso8601
  }
  @response_hash = @charges.create(request_hash.to_hash, @customer['id'])
  @charge.update_attributes(openpay_id: @response_hash['id'], customer_id: @response_hash['customer_id'], order_id: @charge.invoice.custom_id + @charge.invoice.tickets_number.to_s,  
    payment_method: @response_hash['payment_method']['type'], payment_method_id: @response_hash['payment_method']['barcode_url'], 
    payment_method_number: @response_hash['payment_method']['reference'], authorization: @response_hash['authorization'], description: @description,
    status: @response_hash['status'], custom_id: "C#{@charge.id.to_s}I#{@charge.invoice_id.to_s}P#{@charge.invoice.tickets.first.publication_id.to_s}U#{@charge.invoice.buyer_id.to_s}#{truncate(@charge.invoice.tickets.first.publication.event.title.gsub(' ', '').upcase, length: 8, omission: '')}")
rescue OpenpayTransactionException => error
  error_details(error)
end

def create_credit_card
  card_hash = { holder_name: @charge.holder_name, card_number: @charge.card_number, cvv2: @charge.cvv2, expiration_month: @charge.expiration_month, expiration_year: @charge.expiration_year, address: @address_hash}  
  card = @cards.create(card_hash.to_hash, @user.openpay_id)  
  return card
rescue OpenpayTransactionException => error
  error_details(error)
end

def create_credit_debit_card
  stablich_connection
  customer = check_if_customer_exists_global(@user)
  card_hash={
    token_id: @token_id,
    device_session_id: @device_session_id
  }
  @response_hash = @cards.create(card_hash.to_hash, customer['id'])
rescue OpenpayTransactionException => error
  error_details(error)
end

def create_bank_account
  @create_bank_account = true
  stablich_connection
  customer = check_if_customer_exists_global(@user)
  request_hash={
    holder_name: @holder_name,
    alias: @account_name,
    clabe: @bank_account
  }
  @response_hash = @bank_accounts.create(request_hash.to_hash, customer['id'])
rescue OpenpayTransactionException => error
  error_details(error)
end 

def delete_credit_debit_card
  stablich_connection
  @response_hash = @cards.delete(@item_id, @user.openpay_id)
rescue OpenpayTransactionException => error
  error_details(error)
end 

def delete_customer_bank_account
  stablich_connection
  @response_hash = @bank_accounts.delete(@user.openpay_id, @item_id)
rescue OpenpayTransactionException => error
  error_details(error)
end 

def get_credit_card
  card = @cards.get(@charge.credit_card_id, @charge.invoice.buyer.openpay_id)  
  return card
rescue OpenpayTransactionException => error
  error_details(error)
end

def get_customer_credit_cars(user)
  stablich_connection
  check_if_customer_exists_global(user)
  return @cards.all(user.openpay_id)
rescue OpenpayTransactionException => error
  error_details(error)
end

def get_customer_bank_accounts(user)
  stablich_connection
  check_if_customer_exists_global(user)
  return @bank_accounts.all(user.openpay_id)
rescue OpenpayTransactionException => error
  error_details(error)
end

def check_if_customer_exists_global(user)  
  if user.openpay_id.nil? or user.openpay_id.blank?
    customer = create_customer_without_address(user)
  else
    customer = get_customer(user.openpay_id)
  end
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end

def check_if_customer_exists(user, invoice)
  @user = user 
  if user.openpay_id.nil? or user.openpay_id.blank?
    customer = create_customer(user, invoice)
  else
    customer = update_customer_info(user, invoice) 
  end
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end

def get_customer(customer_id)
  customer = @customers.get(customer_id)
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
  if @invalide_code == 1005
    @user.update_attribute(:openpay_id, nil) if @user
    create_bank_account if @create_bank_account
  end
end 

def create_customer_without_address(user)
  user_address_hash = {
    line1: 'N/A', line2: 'N/A', line3: 'N/A', state: 'N/A',
    city: 'N/A', postal_code: 'N/A', country_code: 'MX'
  }  
  customer_hash = {name: user.first_name, last_name: user.last_name, email: user.email, requires_account: false, phone_number: user.phone, address: user_address_hash}    
  customer = @customers.create(customer_hash.to_hash)
  user.update_attribute(:openpay_id, customer["id"]) unless customer["id"].nil?
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end

def create_customer(user, invoice)
  user_address_hash = {
    line1: "#{invoice.address1} #{invoice.external_number}", line2: invoice.address2, line3: invoice.address_references, state: invoice.city.state.name,
    city: invoice.city.name, postal_code: invoice.zipcode, country_code: 'MX'
  }  
  customer_hash = {name: user.first_name, last_name: user.last_name, email: user.email, requires_account: false, phone_number: user.phone, address: user_address_hash}    
  customer = @customers.create(customer_hash.to_hash)
  user.update_attribute(:openpay_id, customer["id"]) unless customer["id"].nil?
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end

def update_customer_info(user, invoice)
  user_address_hash = {
    line1: "#{invoice.address1} #{invoice.external_number}", line2: invoice.address2, line3: invoice.address_references, 
    state: State.find_by_id(invoice.city.state_id).name, city: invoice.city.name, postal_code: invoice.zipcode, country_code: 'MX'
  }  
  customer_hash = {name: user.first_name, last_name: user.last_name, email: user.email, phone_number: user.phone, address: user_address_hash}    
  customer = @customers.update(customer_hash.to_hash, user.openpay_id)
  return customer
rescue OpenpayTransactionException => error
  error_details(error)
end 


def error_details(error)
  @invalid = true
  @invalide_code = error.error_code
  @invalid_description = "#{error.description} (#{error.http_code}|#{error.error_code})" 
end

def get_card_error_code
  reason = 'Hubo un problema con tu pago, intenta de nuevo con otro metodo de pago.'
  if @invalide_code == 1000
    reason = 'Ocurrió un error interno de Openpay.'
  elsif @invalide_code == 1001
    reason = 'Por favor revisa tus datos e intenta de nuevo (1001).'
  elsif @invalide_code == 1002
    reason = 'Por favor revisa tus datos e intenta de nuevo (1002).'
  elsif @invalide_code == 1003
    reason = 'La operación no se pudo completar.  Por favor revisa tus datos e intenta de nuevo.'
  elsif @invalide_code == 1004
    reason = 'No hemos podido completar tu solicitud.  Por favor intenta de nuevo más tarde (1004).'
  elsif @invalide_code == 1005
    reason = 'No hemos podido completar tu solicitud.  Por favor intenta de nuevo más tarde (1005).'
  elsif @invalide_code == 1006
    reason = 'Ya existe una transacción con el mismo ID de orden.'
  elsif @invalide_code == 1007
    reason = 'La transferencia de fondos entre una cuenta de banco o tarjeta y la cuenta de Openpay no fue aceptada.'
  elsif @invalide_code == 1008
    reason = 'Una de las cuentas requeridas en la petición se encuentra desactivada.'
  elsif @invalide_code == 1009
    reason = 'El cuerpo de la petición es demasiado grande.'
  elsif @invalide_code == 1010
    reason = 'Se esta utilizando la llave pública para hacer una llamada que requiere la llave privada, o bien, se esta usando la llave privada desde JavaScript.'
  elsif @invalide_code == 1011
    reason = 'Tu compra no pudo ser procesada, por favor intenta de nuevo.'
  elsif @invalide_code == 1012
    reason = 'Tu compra sobrepasa el limite permitido por el sistema de pagos.  Ponte en contacto con nosotros para seguir adelante.'
  elsif @invalide_code == 1013
    reason = 'Tu compra no pudo ser procesada, por favor intenta de nuevo.'
  elsif @invalide_code == 1014
    reason = 'Tu cuenta ha sido suspendida, por favor contacta a contacto@bolettos.com para más información.'
  elsif @invalide_code == 1015
    reason = 'No pudimos procesar tu transacción, por favor inténtalo más tarde.'
  elsif @invalide_code == 1016
    reason = 'Hubo un problema al realizar tu pago, por favor inténtalo más tarde.'
  elsif @invalide_code == 2001
    reason = 'La cuenta de banco se registró corectamente.'
  elsif @invalide_code == 2002
    reason = 'Esta tarjeta ya se encuentra registrada en el perfil.'
  elsif @invalide_code == 2003
    reason = 'El cliente con este identificador externo (External ID) ya existe.'
  elsif @invalide_code == 2004
    reason = 'El dígito verificador del número de tarjeta es inválido.'
  elsif @invalide_code == 2005
    reason = 'La fecha de expiración de la tarjeta es anterior a la fecha actual.'
  elsif @invalide_code == 2006
    reason = 'El código de seguridad de la tarjeta (CVV2) no fue proporcionado.'
  elsif @invalide_code == 2007
    reason = 'El número de tarjeta es de prueba, solamente puede usarse en Sandbox.'
  elsif @invalide_code == 2008
    reason = 'Esta tarjeta no es valida para puntos de Santander.'
  elsif @invalide_code == 3001
    reason = 'La tarjeta introducida fue rechazada.'
  elsif @invalide_code == 3002
    reason = 'La tarjeta introducida ha expirado.'
  elsif @invalide_code == 3003
    reason = 'La tarjeta introducida no tiene fondos suficientes.'
  elsif @invalide_code == 3004
    reason = 'La tarjeta introducida ha sido identificada como una tarjeta robada.'
  elsif @invalide_code == 3005
    reason = 'Tu pago fue rechazado por el sistema de detección de riesgo.  Intenta de nuevo desde una conexión segura.'
  elsif @invalide_code == 3006
    reason = "412 Precondition Failed    La operación no esta permitida para este cliente o esta transacción."
  elsif @invalide_code == 3007
    reason = "La tarjeta fue declinada."
  elsif @invalide_code == 3008
    reason = "La tarjeta no es soportada en transacciones en línea."
  elsif @invalide_code == 3009
    reason = "La tarjeta fue reportada como perdida."
  elsif @invalide_code == 3010
    reason = "El banco ha restringido la tarjeta."
  elsif @invalide_code == 3011
    reason = "El banco ha solicitado que la tarjeta sea retenida. Contacte al banco."
  elsif @invalide_code == 3012
    reason = "Se requiere solicitar al banco autorización para realizar este pago."
  elsif @invalide_code == 4001
    reason = 'La cuenta de Openpay no tiene fondos suficientes.'
  elsif @invalide_code == 4002
    reason = 'La transacción no puede ser realizada hasta que se cubran todos los cargos pendientes.'
  elsif @invalide_code == 5001
    reason = 'Ya existe una orden con el mismo id, por favor realiza otra compra.'
  elsif @invalide_code == 6001
    reason = 'La petición ya ha sido procesada.'
  elsif @invalide_code == 6002
    reason = 'La petición no puede ser realizada, por favor verifica la URL'
  elsif @invalide_code == 6003
    reason = 'Error de servidor. Por favor inténtalo más tarde.'
  elsif @invalide_code == 7001
    reason = 'La referencia es invalida.'
  elsif @invalide_code == 7002
    reason = 'La orden no fue encontrada.'
  elsif @invalide_code == 7021
    reason = 'La orden ya ha sido completada.'
  elsif @invalide_code == 7022
    reason = 'La orden ya expiró.'
  elsif @invalide_code == 7023
    reason = 'La orden ha sido cancelada.'
  elsif @invalide_code == 7031
    reason = 'El monto no cubre la cantidad mínima.'
  elsif @invalide_code == 7032
    reason = 'El pago final es requerido.'
  elsif @invalide_code == 7033
    reason = 'El pago excede el monto de la orden.'
  elsif @invalide_code == 7040
    reason = 'El pago no puede ser cancelado.'
  elsif @invalide_code == 7041
    reason = 'El pago ya ha sido cancelado.'
  elsif @invalide_code == 7042
    reason = 'El pago no ha sido encontrado.'
  elsif @invalide_code == 7043
    reason = 'La suma a cancelar es incorrecta.'
  else
    reason = "#{@invalid_description}."
  end
  return reason
end