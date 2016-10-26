class BuyMailer < ActionMailer::Base
    default from: "no-reply@donbillete.com"

	def buy_saldo(user,saldo)
		@user = user
		@saldo = saldo
		mail(to: @user.email, subject: '[DonBillete] Compra de Saldo DonBillete')
	end

    def admin_resume_lottery(lottery)
        @lottery = lottery
        @mails = ['alfredo_anchondo@hotmail.com','marianolascurain@gmail.com','rodrigolascurain@gmail.com']
        mail(to: @mails, subject: '[DonBillete] Resumen de loteria')
    end

    def close_question(mail,status,ticket)
       @mail = mail
       @status = status
       @ticket = ticket
      	mail(to: @mail, subject: '[DonBillete] Respuesta a Pregunta Enrachate')
    end

     def admin_resume_tira(tira)
        @tira = tira
        @mails = ['alfredo_anchondo@hotmail.com','marianolascurain@gmail.com','rodrigolascurain@gmail.com']
        mail(to: @mails, subject: '[DonBillete] Resumen de Tira')
    end

	def buy_survivor_entry(survivor,user, next_week)
		@user = user
		@survivor = survivor
		@next_week = next_week
		mail(to: @user.email, subject: '[DonBillete] Compra de entrada liga survivor')
	end

	def buy_pick_entry(pick,user, next_week)
		@user = user
		@pick = pick
		@next_week = next_week
		mail(to: @user.email, subject: "[DonBillete] Compra de entrada liga PICK'EM")
	end

	def buy_survivor_team(survivor,user, next_week, team)
		@user = user
		@survivor = survivor
		@next_week = next_week
		@team = team
    attachments.inline['team.png'] = File.read(@team.logo_path)
    attachments.inline['logo.png'] = File.read("/donbilleteblanco.png")
    attachments.inline['hero.png'] = File.read("http://donbillete.com/seleccionteamsurvivor.png")
    attachments.inline['fondo.png'] = File.read("http://donbillete.com/assets/images/bg1.jpg")


		mail(to: @user.email, subject: '[DonBillete] Seleccion de equipo semanal liga survivor')
	end

	def invite(mails,reference,user)
		@mails = mails
		@reference = reference
		@user = user
		mail(to: @mails, subject: '[DonBillete] Un amigo te invita a registrarte')
	end

	def invite_survivor(mails,survivor,user)
		@mails = mails
		@survivor = survivor
		@user = user
		mail(to: @mails, subject: '[DonBillete] Un amigo te invita a participar en su liga de survivor')
	end

    def invite_pick(mails,survivor,user)
		@mails = mails
		@survivor = survivor
		@user = user
		mail(to: @mails, subject: '[DonBillete] Un amigo te invita a participar en su liga de pick')
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

	def access_request_mail(current_user, owner, survivor)
		@current_user = current_user
		@owner = owner
		@survivor = survivor
		mail(to: @owner.email, subject: 'Solicitud de acceso a tu liga survivor')
	end

    def access_request_mail_pick(current_user, owner, survivor)
		@current_user = current_user
		@owner = owner
		@survivor = survivor
		mail(to: @owner.email, subject: 'Solicitud de acceso a tu liga survivor')
	end

	def winner_survivor(survivor, user, winners, total_win)
		@survivor = survivor
		@user = user
		@winners = winners
		@total_win = total_win
		mail(to: @user.email, subject: '[DonBillete] Ganador de una liga survivor')
	end

    def response_access(request, owner, survivor, response)
		@request = request
		@owner = owner
		@survivor = survivor
		@response = response
		mail(to: @request.email, subject: '[DonBillete] Respuesta a solicitud de acceso a liga survivor')
	end

    def response_access_pick(request, owner, survivor, response)
		@request = request
		@owner = owner
		@survivor = survivor
		@response = response
		mail(to: @request.email, subject: "[DonBillete] Respuesta a solicitud de acceso a liga PICK'EM")
	end
end
