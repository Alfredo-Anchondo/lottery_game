class BuyMailer < ActionMailer::Base
    default from: "no-reply@donbillete.com"

    
    def buy_ticket(user, lottery, lottery_user)
    @user = user
    @lottery = lottery  
    @user_lottery = lottery_user    
    @url  = 'http://example.com/login'
        mail(to: @user.email, subject: '[DonBillete] Comprobante de Compra')
  end
    
  def welcome_user(user)
    @user = user  
    @url  = 'http://example.com/login'
        mail(to: @user.email, subject: '[DonBillete] Gracias por Registrarte')
  end
    
    
  def winner_number(emails)
    @emails = emails 
        mail(to: @emails, subject: '[DonBillete] Gracias por Registrarte')
  end
    
end
