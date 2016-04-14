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
    
    
  def winner_number(emails, winner_number, lottery_name)
      @emails = emails 
      @winner_number  = winner_number
      @lottery_name = lottery_name   
      mail(to: @emails, subject: '[DonBillete] Loteria Terminada - Numero ganador de Loteria')
  end
    
    def winner_congratulations(winner, winner_number, lottery_name, total_update, num_winners)
      @winner = winner 
      @winner_number  = winner_number
      @lottery_name = lottery_name   
      @total_update = total_update  
      @num_winners = num_winners    
          mail(to: @winner, subject: '[DonBillete] Felicidades eres el Ganador de la Loteria')
  end
    
    def close_lottery(game, lottery, mail)
        @game = game
        @mail = mail
        @lottery = lottery
        @mail.each do |variable|
            @tickets = UserLottery.where('user_id = ? AND lottery_id = ?' ,variable[1], @lottery.id).pluck(:ticket_number)
        mail(to: variable[0], subject: '[DonBillete] La loteria se a cerrado')
        end
        
       
    end    
    
end
