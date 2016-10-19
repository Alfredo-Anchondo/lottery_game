class SurvivorGame < ActiveRecord::Base
  #SCOPES
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM game_date) = ?", year) }

  #ASSOCIATIONS
  belongs_to :team
  belongs_to :team2
  belongs_to :survivor_week_game
  has_many :picks, :through => :survivor_week_game

  #VALIDATIONS
  validate :team_id, :team2_id, :survivor_week_game_id, :game_date, :presence => true

  #CALLBACKS
  after_update :change_status
  after_update :pending_games

  #METHODS

	def name
	'' + team.name.to_s + ' vs ' + team2.name.to_s + ''
	end

  def self.no_pending_games?
    SurvivorGame.from_year.count == SurvivorGame.from_year.where.not(:local_score => nil, :visit_score => nil).count
  end

  def past_game
	  if (game_date <= Time.now)
		  return "passgame"
	  else
		  return ''
	  end
  end

  protected

  def close_pick_game

  end

  def change_status

      if survivor_week_game.sport_category == 12

          if local_score > visit_score
              winner_team = team.id
          else
             if local_score == visit_score
              winner_team = 185
          else
              winner_team = team2.id
          end
          end
            partido = survivor_week_game.survivor_games.order(:game_date).last
            elegidos =  survivor_week_game.pick_users.each do |pick_user|
            games_user = PickUserGame.where(:pick_user_id => pick_user.id)
            games_user.where('survivor_game_id = ?', id).each do |game|

                if partido.id == id
                    if pick_user.local_score == local_score && pick_user.visit_score == visit_score
                        pick_user.update(:points => pick_user.points ? pick_user.points + 3 : 0 + 3)
                    end
                end

                 if game.team_id == winner_team
                     if winner_team == 185
                       pick_user.update(:points => pick_user.points ? pick_user.points + 2 : 0 + 2 )
                     else
                     pick_user.update(:points => pick_user.points ? pick_user.points + game.points : 0 + game.points )
                     end
                     game.update(:status => 'winner')
                     logger.info 'Se realizo la suma de puntos'
                     else
                     game.update(:status => 'loser')
                 end
             end
            end
          logger.info "Entre y se que soy de futball carnal !!!!!!!!!!!!!!!"
      else

      if type_update == '1'
        if plus_handicap == 1
            visitor_handicap = handicap
            local_handicap = handicap * -1
        else
            visitor_handicap = handicap * -1
            local_handicap = handicap
        end

        local_score_total = local_score + local_handicap
        visit_score_total = visit_score + visitor_handicap
        two_winners = ''

          logger.info local_score_total
          logger.info visit_score_total

          if local_score_total > visit_score.to_i
             logger.info "El marcado local es mayor al del visitante"
              winner_team_final = team.id
              else
              winner_team_final = team2.id
              logger.info "el ganado es el equipo visitante"
          end


         elegidos =  survivor_week_game.pick_users.each do |pick_user|
            games_user = PickUserGame.where(:pick_user_id => pick_user.id)
             games_user.where('survivor_game_id = ?', id).each do |game|
                 if two_winners != ''
                     if game.team_id == two_winners || game.team_id == winner_team_final
                     game.update(:status => 'loser')
                     logger.info 'Se realizo la suma de puntos'
                     else
                 end
                 end
                 if game.team_id == winner_team_final
                     pick_user.update(:points => pick_user.points ? pick_user.points + game.points : 0 + game.points )
                     game.update(:status => 'winner')
                     logger.info 'Se realizo la suma de puntos'
                     else
                     game.update(:status => 'loser')
                 end
             end
         end
         logger.info elegidos

      else
  end
  end

    if winner_team_changed?

		if local_score == visit_score
		  survivor_week_game
		  .survivor_users
		  .where(:team_id => team_id)
		  .update_all(:status => "loser")

		  survivor_week_game
		  .survivor_users
		  .where(:team_id => team2_id)
		  .update_all(:status => "loser")

		else
            logger.info "Entre en el ciclo pero de seguro los ids estan mal y por eso esto esta valiendo pura vergota"
            logger.info winner_team
            logger.info local_score
            logger.info visit_score
            if local_score > visit_score
                winner_team = team_id
            else
                 winner_team = team2_id
            end
          loser_team = (winner_team == team_id) ? team2_id : team_id
		  winner_status = (survivor_week_game.last_week?)? "winner" : "alive"

		  survivor_week_game
		  .survivor_users
		  .where(:team_id => winner_team)
		  .update_all(:status => winner_status)

		  survivor_week_game
		  .survivor_users
		  .where(:team_id => loser_team)
		  .update_all(:status => "loser")
		end
      end
    end
  end

	def pending_games
		pending = false
		games = SurvivorGame.where(:survivor_week_game_id => survivor_week_game.id)
		games.each do |game|
			if game.winner_team.present?
			else
				pending = true
			end
		end

            if type_update == '1'
                last_pick = ""
                winner_week = ""
                porcentaje = ""
                balance = ""

                #----------------------------------football soccer pick -----------------------------------

                if survivor_week_game.pick_users[0].pick.sport_category_id == 12

                if type_update == '1'
                last_pick = ""
                winner_week = ""
                porcentaje = ""
                balance = ""

                if pending == false
                  picks = Pick.where('sport_category_id = ?', survivor_week_game.pick_users[0].pick.sport_category_id )
                    picks.each do |pickx|
                            if survivor_week_game.week == 1
                                 if pickx.percentage.present?
                                     total_porcentage = (pickx.percentage/100) * pickx.initial_balance
                                     pickx.update(:initial_balance => (pickx.initial_balance - total_porcentage) )
                                     pickx.user.update(:balance => pickx.user.balance + total_porcentage)

                                 end
                            end
                          #Aqui comienza la creacion de un nuevo ticket si no se compro
                         pick_survivor = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id = ?', survivor_week_game.id, pickx.id).first
                if pick_survivor != nil && pick_survivor != []
                last_week_number = survivor_week_game.week - 1
				category = survivor_week_game.sport_category
				last_week_game = SurvivorWeekGame.where(:week => last_week_number, :sport_category => category).first
				logger.info last_week_game.id
				logger.info '/////////////'
				survivor_week_survivors = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id =?', last_week_game.id, pickx.id )
                survivor_week_survivors_current = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id =?', survivor_week_game.id, pickx.id )
                last_tickets = survivor_week_survivors[0].pick_users.order(:pick_user_id)
				current_tickets = survivor_week_survivors_current[0].pick_users.order(:pick_user_id)

				if current_tickets.count != last_tickets.count
					currents = []
					lasts = []
					current_tickets.each_with_index do|ticket, index_s|
						currents.push({pick: ticket.pick_survivor_week.pick.id ,pick_user_id: ticket.pick_user.id, user_id: ticket.user.id, index: index_s })
					end
					last_tickets.each_with_index do|ticket, index_s|
						lasts.push({pick: ticket.pick_survivor_week.pick.id, pick_user_id: ticket.pick_user.id, user_id: ticket.user.id, index: index_s })
					end
					logger.info lasts
					lasts.each do |ticket|
						x = currents.include?(ticket) ? "Si existe en el arreglo" :  "No existe en el arreglo"
						logger.info x
						if x == "No existe en el arreglo"
						 survivor_week_survivor_current_id = PickSurvivorWeek.where('pick_id = ? AND survivor_week_game_id = ?',ticket[:pick],survivor_week_game.id ).pluck(:id).first
							sur = PickUser.new(pick_survivor_week_id: survivor_week_survivor_current_id , pick_user_id: ticket[:pick_user_id], points: 0, user_id: ticket[:user_id], status: 'loser')
							sur.save()
                            logger.info 'Se creo un nuevo boleto'
							else
						end
					end

					logger.info 'un usuario no selecciono ticket en la semana pasada'
					logger.info lasts
					logger.info currents
					else
                    logger.info 'todos las entradas estan correctas'
				end
                end
                    #aqui termina la creacion de el ticket si falta


                        pick_survivor = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id = ?', survivor_week_game.id, pickx.id).first
                        logger.info survivor_week_game.id
                        logger.info pickx.id
                        logger.info pick_survivor
                       if pick_survivor != nil && pick_survivor != []
                        max_points = pick_survivor.pick_users.maximum("points")
                        winner_week = pick_survivor.pick_users.where(:points => max_points)
                           logger.info max_points
                           logger.info winner_week
                           logger.info winner_week.length
                           logger.info 'esta es la ultima que se ahace'
                        porcentaje = pickx.percentage_per_week
                        balance = pickx.initial_balance

                        if winner_week != nil && winner_week != []
                            if winner_week.length > 1
                            porcentaje = porcentaje/100
                                balance_sum = (balance * porcentaje)/winner_week.count
                                 winner_week.each do |winner_pos|
                                     logger.info 'Entre en este ciclo del array'
                                     winner_pos.update(:status => 'Ganadorsemanal')
                                     winner_pos.user.update(:balance => winner_pos.user.balance + balance_sum)
                                 end

                        else
                            winner_week[0].update(:status => 'Ganadorsemanal')
                            porcentaje = porcentaje/100
                            balance_sum = balance * porcentaje
                            winner_week[0].user.update(:balance => winner_week[0].user.balance + balance_sum )
                        end
                        else
                        end
                           else
                       end



                    end

                end
            end
                 return true
            end

                #------------------------------------termina el pick de futball soccer --------------------

                if pending == false
                  picks = Pick.where('sport_category_id = ?', survivor_week_game.pick_users[0].pick.sport_category_id )
                    picks.each do |pickx|
                            if survivor_week_game.week == 1
                                 if pickx.percentage.present?
                                     total_porcentage = (pickx.percentage/100) * pickx.initial_balance
                                     pickx.update(:initial_balance => (pickx.initial_balance - total_porcentage) )
                                     pickx.user.update(:balance => pickx.user.balance + total_porcentage)

                                 end
                            end
                          #Aqui comienza la creacion de un nuevo ticket si no se compro
                         pick_survivor = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id = ?', survivor_week_game.id, pickx.id).first
                if pick_survivor != nil && pick_survivor != []
                last_week_number = survivor_week_game.week - 1
				category = survivor_week_game.sport_category
				last_week_game = SurvivorWeekGame.where(:week => last_week_number, :sport_category => category).first
				logger.info last_week_game.id
				logger.info '/////////////'
				survivor_week_survivors = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id =?', last_week_game.id, pickx.id )
                survivor_week_survivors_current = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id =?', survivor_week_game.id, pickx.id )
                last_tickets = survivor_week_survivors[0].pick_users.order(:pick_user_id)
				current_tickets = survivor_week_survivors_current[0].pick_users.order(:pick_user_id)

				if current_tickets.count != last_tickets.count
					currents = []
					lasts = []
					current_tickets.each_with_index do|ticket, index_s|
						currents.push({pick: ticket.pick_survivor_week.pick.id ,pick_user_id: ticket.pick_user.id, user_id: ticket.user.id, index: index_s })
					end
					last_tickets.each_with_index do|ticket, index_s|
						lasts.push({pick: ticket.pick_survivor_week.pick.id, pick_user_id: ticket.pick_user.id, user_id: ticket.user.id, index: index_s })
					end
					logger.info lasts
					lasts.each do |ticket|
						x = currents.include?(ticket) ? "Si existe en el arreglo" :  "No existe en el arreglo"
						logger.info x
						if x == "No existe en el arreglo"
						 survivor_week_survivor_current_id = PickSurvivorWeek.where('pick_id = ? AND survivor_week_game_id = ?',ticket[:pick],survivor_week_game.id ).pluck(:id).first
							sur = PickUser.new(pick_survivor_week_id: survivor_week_survivor_current_id , pick_user_id: ticket[:pick_user_id], points: 0, user_id: ticket[:user_id], status: 'loser')
							sur.save()
                            logger.info 'Se creo un nuevo boleto'
							else
						end
					end

					logger.info 'un usuario no selecciono ticket en la semana pasada'
					logger.info lasts
					logger.info currents
					else
                    logger.info 'todos las entradas estan correctas'
				end
                end
                    #aqui termina la creacion de el ticket si falta


                        pick_survivor = pickx.pick_survivor_weeks.where('survivor_week_game_id = ? and pick_id = ?', survivor_week_game.id, pickx.id).first
                        logger.info survivor_week_game.id
                        logger.info pickx.id
                        logger.info pick_survivor
                       if pick_survivor != nil && pick_survivor != []
                        max_points = pick_survivor.pick_users.maximum("points")
                        winner_week = pick_survivor.pick_users.where(:points => max_points)
                           logger.info max_points
                           logger.info winner_week
                           logger.info winner_week.length
                           logger.info 'esta es la ultima que se ahace'
                        porcentaje = pickx.percentage_per_week
                        balance = pickx.initial_balance

                        if winner_week != nil && winner_week != []
                            if winner_week.length > 1
                            array_pos = []
                            winner_week.each do |pos_win|
                              local_error =  (pos_win.local_score ? pos_win.local_score : 0 - local_score).abs
                              visit_error =  (pos_win.visit_score ? pos_win.visit_score : 0  - visit_score).abs
                              total_error =  local_error + visit_error
                              array_pos.push(total_error)
                                 logger.info 'HAY MAS DE UN GANADOR'
                                 logger.info total_error
                            end
                                array_pos.min
                                logger.info 'el minimo es'
                                logger.info array_pos.each_with_index.min
                                result = array_pos.each_with_index.min
                                logger.info result[0]
                                logger.info array_pos.index(result[0])
                                count_winners = 0
                                array_winner_pos = []
                                array_pos.each_with_index do |position, is|
                                    if position == result[0]
                                        logger.info 'entre en el ciclo'
                                        count_winners += 1
                                        array_winner_pos.push(is)
                                    end
                                end

                             if count_winners > 1
                               porcentaje = porcentaje/100
                                balance_sum = (balance * porcentaje)/winner_week.count
                                 array_winner_pos.each do |winner_pos|
                                     logger.info 'Entre en este ciclo del array'
                                     winner_week[winner_pos].update(:status => 'Ganadorsemanal')
                                     winner_week[winner_pos].user.update(:balance => winner_week[winner_pos].user.balance + balance_sum)
                                 end

                               #  winner_week.each do |winnerz|
                                #     winnerz.update(:status => 'Ganadorsemanal')
                                 #    winnerz.user.update(:balance => winnerz.user.balance + balance_sum)
                                # end

                             else
                                  winner_week = winner_week[result[1]]
                                winner_week.update(:status => 'Ganadorsemanal')
                                porcentaje = porcentaje/100
                                balance_sum = balance * porcentaje
                                winner_week.user.update(:balance => winner_week.user.balance + balance_sum )
                             end

                        else
                            winner_week[0].update(:status => 'Ganadorsemanal')
                            porcentaje = porcentaje/100
                            balance_sum = balance * porcentaje
                            winner_week[0].user.update(:balance => winner_week[0].user.balance + balance_sum )
                        end
                        else
                        end
                           else
                       end



                    end

                end
            end


			if pending == true

				logger.info "Aun hay juegos pendientes"
				else
                 if survivor_week_game.pick_users[0].pick.sport_category_id == 12
                     return
                  end
				logger.info "Ya no hay juegos pendientes"
				last_week_number = survivor_week_game.week - 1
				category = survivor_week_game.sport_category
				last_week_game = SurvivorWeekGame.where(:week => last_week_number, :sport_category => category).first
				logger.info last_week_game.id
				logger.info '/////////////'
				survivor_week_survivors = SurvivorWeekSurvivor.where(:survivor_week_game => last_week_game.id)
				last_tickets = survivor_week_survivors[0].survivor_week_game.survivor_users
				current_tickets = survivor_week_game.survivor_users



                	if current_tickets.count != last_tickets.count
					currents = []
					lasts = []
					current_tickets.each do|ticket|
                        if ticket.survivor_week_survivor.survivor.status == 'Cerrada'
                        else
                            currents.push({survivor: ticket.survivor_week_survivor.survivor.id ,survivor_user_id: ticket.survivor_user.id, user_id: ticket.user_id })
                        end
					end
					last_tickets.each do|ticket|
                        if ticket.survivor_week_survivor.survivor.status == 'Cerrada'
                        else
                            lasts.push({survivor: ticket.survivor_week_survivor.survivor.id, survivor_user_id: ticket.survivor_user.id, user_id: ticket.user_id })
                        end

					end
					logger.info lasts
					lasts.each do |ticket|
						x = currents.include?(ticket) ? "Si existe en el arreglo" :  "No existe en el arreglo"
						logger.info x
						if x == "No existe en el arreglo"
						 survivor_week_survivor_current_id = SurvivorWeekSurvivor.where('survivor_id = ? AND survivor_week_game_id = ?',ticket[:survivor],survivor_week_game.id ).pluck(:id).first
							sur = SurvivorUser.new(survivor_week_survivor_id: survivor_week_survivor_current_id , survivor_user_id: ticket[:survivor_user_id], purchase_date: DateTime.now.to_date, user_id: ticket[:user_id], status: 'loser')
							sur.save()
                            logger.info survivor_week_survivor_current_id
                            logger.info 'se creo la entrada en blanco'
							else
						end
					end

					logger.info 'un usuario no selecciono ticket en la semana pasada'
					logger.info lasts
					logger.info currents
                    logger.info current_tickets

					else
				    end


                     current_tickets2 =  survivor_week_game.survivor_users
                Survivor.where('status = ?','Enjuego').each do |survivor|
                    looser_can_saves = false
                    looser_with_rebuy = 0
                    no_more_rebuys = false
                    looser_id = ''
                    if survivor.survivor_users.count >= 1
                      if current_tickets2.where('survivor_id = ? and status = ?', survivor.id, 'alive' ).pluck(:user_id).uniq.count <= 1
                          logger.info 'Esta entrando por que el numero de vivos es 1 0 menor'
                          deel = current_tickets2.pluck()

                          enter_cycle = false
                          current_tickets2.each do |ticket|
                              enter_cycle = true
                          end

                          if enter_cycle == false

                            deel.each do |ticket|
                               p ticket
                               p 'que rollo aqui esta uno'
                               logger.info ticket[4]
                              logger.info ticket[8]
                           logger.info 'Status del ticket que se esta iterando'
                        quantity_lose = survivor.survivor_users.where('survivor_user_id = ? AND status = ?', ticket[8], 'loser')
                             if quantity_lose != nil && quantity_lose != []
                                 if quantity_lose.count >= survivor.rebuy_quantity
                                   logger.info survivor.name
                                   logger.info ticket[4]
                                   logger.info 'Ya no tiene recompras disponibles'
                                   logger.info quantity_lose.count
                                 else
                                   no_more_rebuys = true
                                   logger.info survivor.name
                                    if ticket[4] == 'loser'
                                        logger.info 'Aun tienes recompras disponibles'
                                        logger.info quantity_lose.count
                                        looser_can_saves = true
                                        looser_with_rebuy += 1
                                        looser_id = ticket[8]
                                    else
                                        logger.info 'Aun tienes recompras disponibles PERO ERES EL UNICO VIVO NO TE PREOCUPES'
                                        logger.info quantity_lose.count
                                    end

                                  end
                             else
                                 logger.info 'No existe esas entradas'
                             end
                           end

                              if no_more_rebuys == false
                                  deel.each do |ticket|
                                      SurvivorUser.find(ticket[0]).update(:status => 'winner')
                                  end

                              end



                          end



                       current_tickets2.each do |ticket|
                           logger.info ticket.status
                           logger.info 'Status del ticket que se esta iterando'
                        quantity_lose = survivor.survivor_users.where('survivor_user_id = ? AND status = ?', ticket.survivor_user_id, 'loser')
                             if quantity_lose != nil && quantity_lose != []
                                 if quantity_lose.count > survivor.rebuy_quantity
                                   logger.info survivor.name
                                   logger.info ticket.status
                                   logger.info 'Ya no tiene recompras disponibles'
                                   logger.info quantity_lose.count
                                 else
                                   logger.info survivor.name
                                    if ticket.status == 'loser'
                                        logger.info 'Aun tienes recompras disponibles'
                                        logger.info quantity_lose.count
                                        looser_can_saves = true
                                        looser_with_rebuy += 1
                                        looser_id = ticket.survivor_user_id
                                    else
                                        logger.info 'Aun tienes recompras disponibles PERO ERES EL UNICO VIVO NO TE PREOCUPES'
                                        logger.info quantity_lose.count
                                    end

                                  end
                             else
                                 logger.info 'No existe esas entradas'
                             end
                     end
                        logger.info looser_can_saves
                        logger.info 'se salvara????????'
                        logger.info  'AUN SIGUE EL JUEGOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
                        logger.info looser_with_rebuy
                        logger.info survivor.survivor_users.where('status = ?', 'alive').count

                        if looser_with_rebuy == 1 && current_tickets2.where('status = ?', 'alive').count == 0
                            logger.info 'entre a esta opcion'
                            current_tickets.where('survivor_user_id = ?', looser_id).first.update(:status => 'winner')

                             total_winners = survivor.survivor_users.winner.count

                                logger.info total_winners
                                if total_winners > 0 && survivor.initial_balance > 0
                                  if survivor.percentage.present?
                                    percentage_profit = survivor.initial_balance * survivor.percentage.to_f / 100
                                    survivor.user.update(:balance => survivor.user.balance + percentage_profit.to_f / 2)
                                    profit = (survivor.initial_balance.to_f - percentage_profit) / total_winners
                                  else
                                    profit = survivor.initial_balance.to_f / total_winners
                                  end

                                  survivor.survivor_users.winner.each do |su|
                                    su.user.update(:balance => su.user.balance + profit)
                                    BuyMailer.winner_survivor(survivor,su.user,survivor.survivor_users.winner.count,profit).deliver
                                  end
                                    survivor.update(:status => 'Cerrada')
                                end

                        end

                        logger.info  looser_can_saves
                        logger.info "ANTES DEL IFFFFFFFFFFFFFFFFFFF"
                        if looser_can_saves == false

                            if current_tickets2.where('status = ?', 'alive').count == 1
                              logger.info "Entre al de solo un ganador"
                             winner = current_tickets2.where('status = ?', 'alive')
                             winner[0].update(:status => 'winner')
                             logger.info winner[0]
                            end

                                if current_tickets2.where('status = ?', 'loser').count == current_tickets2.count
                                current_tickets2.each do |ticket|
                                  logger.info "entre en el que hay solo perdedores"
                                    ticket.update(:status => 'winner')
                                    logger.info ticket
                                end
                                end

                            'TENEMOS GANADOR PARA EL SURVIVORRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'

                              total_winners = survivor.survivor_users.winner.count

                                logger.info total_winners
                                if total_winners > 0 && survivor.initial_balance > 0
                                  if survivor.percentage.present?
                                    percentage_profit = survivor.initial_balance * survivor.percentage.to_f / 100
                                    survivor.user.update(:balance => survivor.user.balance + percentage_profit.to_f / 2)
                                    profit = (survivor.initial_balance.to_f - percentage_profit) / total_winners
                                  else
                                    profit = survivor.initial_balance.to_f / total_winners
                                  end

                                  survivor.survivor_users.winner.each do |su|
                                    su.user.update(:balance => su.user.balance + profit)
                                    BuyMailer.winner_survivor(survivor,su.user,survivor.survivor_users.winner.count,profit).deliver
                                  end
                                         survivor.update(:status => 'Cerrada')
                                end

                        else

                        end
                    end
                    else

                    end
                end



			end


	end
