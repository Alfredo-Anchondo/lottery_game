class SurvivorGame < ActiveRecord::Base
  #SCOPES
  scope :from_year, ->(year=Date.current.year) { where("EXTRACT(YEAR FROM game_date) = ?", year) }

  #ASSOCIATIONS
  belongs_to :team
  belongs_to :team2
  belongs_to :survivor_week_game

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

  def change_status
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
	
	def pending_games
		pending = false
		games = SurvivorGame.where(:survivor_week_game_id => survivor_week_game.id) 
		games.each do |game|
			if game.winner_team.present?
			else
				pending = true
			end
		end
		
			if pending == true
				logger.info "Aun hay juegos pendientes"
				
				
				else
				logger.info "Ya no hay juegos pendientes"
				last_week_number = survivor_week_game.week - 1
				last_week_game = SurvivorWeekGame.where(:week => last_week_number).first
				survivor_week_survivors = SurvivorWeekSurvivor.where(:survivor_week_game => last_week_game.id)
				 last_tickets = survivor_week_survivors[0].survivor_week_game.survivor_users	
				current_tickets = survivor_week_game.survivor_users
				
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
end
