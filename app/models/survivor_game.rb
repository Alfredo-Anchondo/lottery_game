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
          
          if local_score_total > visit_score_total
              winner_team_final = team.id
              else if local_score_total = visit_score_total
                two_winners = team2.id
                winner_team_final = team.id
              else
              winner_team_final = team2.id
          end
      end
           
         elegidos =  survivor_week_game.pick_users.each do |pick_user|
            games_user = PickUserGame.where(:pick_user_id => pick_user.id)
             games_user.each do |game|
                 if two_winners != ''
                     if game.team_id == two_winners
                     pick_user.update(:points => pick_user.points ? pick_user.points + game.points : 0 + game.points )
                     logger.info 'Se realizo la suma de puntos'
                     else
                 end
                 end
                 if game.team_id == winner_team_final
                     pick_user.update(:points => pick_user.points ? pick_user.points + game.points : 0 + game.points )
                     logger.info 'Se realizo la suma de puntos'
                     else
                 end
             end
         end
         logger.info elegidos

      else
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
		  loser_team = (winner_team == team_id)? team2_id : team_id
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
                if pending == false
                  picks = Pick.where('sport_category = ?', survivor_week_game.pick_users[0].pick.sport_category )
                    picks.each do |pickx|
                        
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
                           logger.info winner_week
                           logger.info winner_week.length
                        porcentaje = pickx.percentage_per_week
                        balance = pickx.initial_balance
                        
                        if winner_week != nil && winner_week != []
                            if winner_week.length > 1
                            array_pos = []
                            winner_week.each do |pos_win|
                              local_error =  (pos_win.local_score - local_score).abs
                              visit_error =  (pos_win.visit_score - visit_score).abs
                              total_error =  local_error + visit_error    
                              array_pos.push(total_error)    
                                 logger.info 'HAY MAS DE UN GANADOR' 
                                 logger.info total_error
                            end
                               array_pos.min
                                logger.info 'el minimo es'
                                logger.info array_pos.each_with_index.min
                                result = array_pos.each_with_index.min
                                winner_week = winner_week[result[1]]
                            winner_week.update(:status => 'Ganadorsemanal')
                            porcentaje = porcentaje/100
                            balance_sum = balance * porcentaje    
                            winner_week.user.update(:balance => winner_week.user.balance + balance_sum )   
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
				logger.info "Ya no hay juegos pendientes"
				last_week_number = survivor_week_game.week - 1
				category = survivor_week_game.sport_category
				last_week_game = SurvivorWeekGame.where(:week => last_week_number, :sport_category => category).first
				logger.info last_week_game.id
				logger.info '/////////////'
				survivor_week_survivors = SurvivorWeekSurvivor.where(:survivor_week_game => last_week_game.id)
				last_tickets = survivor_week_survivors[0].survivor_week_game.survivor_users	
				current_tickets = survivor_week_game.survivor_users
                

                Survivor.all.each do |survivor|
                    if survivor.survivor_users.count >= 1
                         if current_tickets.where('survivor_id = ? and status = ?', survivor.id, 'alive' ).pluck(:user_id).uniq.count <= 1
                    current_tickets.each do |ticket|
                        quantity_lose = survivor.survivor_users.where('survivor_user_id = ? AND status = ?', ticket.survivor_user_id, 'loser').count
                             if quantity_lose > survivor.rebuy_quantity
                                   logger.info survivor.name
                                   logger.info 'Ya no tiene recompras disponibles'
                                   logger.info quantity_lose
                             else
                                   logger.info survivor.name
                                   logger.info 'Aun tienes recompras disponibles'
                                   logger.info quantity_lose
                             end
                      
                    end
                    logger.info current_tickets.where('survivor_id = ? and status = ?', survivor.id, 'alive' ).pluck(:user_id).uniq.count 
                    logger.info 'ya no hay rivales'
                end
                        else
                    end
               
                    end
                   
				
				if current_tickets.count != last_tickets.count
					currents = []
					lasts = []
					current_tickets.each do|ticket|
						currents.push({survivor: ticket.survivor_week_survivor.survivor.id ,survivor_user_id: ticket.survivor_user.id, user_id: ticket.user_id })
					end
					last_tickets.each do|ticket|
						lasts.push({survivor: ticket.survivor_week_survivor.survivor.id, survivor_user_id: ticket.survivor_user.id, user_id: ticket.user_id })
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
					else
				end
			end
		
		
	end

