class BuyMailer < ActionMailer::Base
    default from: "no-reply@donbillete.com"

	def buy_saldo(user,saldo)
		@user = user
		@saldo = saldo
		mail(to: @user.email, subject: '[DonBillete] Compra de Saldo DonBillete')
	end

	def invite(mails,reference,user)
		@mails = mails
		@reference = reference
		@user = user
		mail(to: @mails, subject: '[DonBillete] Un amigo te invita a registrarte')
	end

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
      mail(to: @emails, subject: '[DonBillete] Loteria Terminada - Número ganador de Loteria')
  end

    def winner_congratulations(winner, winner_number, lottery_name, total_update, num_winners)
      @winner = winner
      @winner_number  = winner_number
      @lottery_name = lottery_name
      @total_update = total_update
      @num_winners = num_winners
          mail(to: @winner, subject: '[DonBillete] Felicidades eres el Ganador de la Loteria')
  end

	def winner_number_quiniela(emails, winner_number, lottery_name)
      @emails = emails
      @winner_number  = winner_number
      @lottery_name = lottery_name
		mail(to: @emails, subject: '[DonBillete] Juego Terminado - Número ganador de Tira')
  end

	def winner_congratulations_quiniela(winner, winner_number, lottery_name, total_update, num_winners)
      @winner = winner
      @winner_number  = winner_number
      @lottery_name = lottery_name
      @total_update = total_update
      @num_winners = num_winners
          mail(to: @winner, subject: '[DonBillete] Felicidades eres el Ganador de la Tira')
  end

    def close_lottery(game, lottery, mail,tickets,repeat,correct_mail)
        @game = game
        @mail = correct_mail
        @lottery = lottery
        @tickets = tickets
        @repeat_number = repeat
        mail(to: @mail, subject: '[DonBillete] La loteria se ha cerrado')
    end

	def close_lottery_quiniela(game, lottery, mail,tickets,repeat,correct_mail)
        @game = game
        @mail = correct_mail
        @lottery = lottery
        @tickets = tickets
        @repeat_number = repeat
        mail(to: @mail, subject: '[DonBillete] La loteria se ha cerrado')
    end

	def buy_many_tickets(user, array, lottery)
		@user = user
		@game = lottery.game
		@array = array
		@lottery = lottery
		mail(to: @user.email, subject: '[DonBillete] Comprobante de compra de billetes')
	end

	def send_mails_all(mails, subject, content)
		mail(to: mails, subject: subject,  body: content,
         content_type: "text/html", )
	end

end
