class WelcomeController < ApplicationController
	before_action :authenticate_user!,  :except => [:no_sign_in, :ho_we_are, :contact, :privacy, :faq]

  def index
       @lotteries = Lottery.where(:to_mainpage => true)
       @tiras = Quiniela.where(:to_mainpage => true)
       @survivors = Survivor.where(:to_mainpage => true)
       @picks = Pick.where(:to_mainpage => true)
			 @enrachates = Enrachate.where("initial_date >= ? and end_date >= ? and winner IS NULL",DateTime.now.to_date,DateTime.now.to_date)
			 @enrachate = Enrachate.where("type_enrachate = ? and end_date > ? and initial_date < ? and winner IS ?",0,Time.now,Time.now, nil).first

			 @current_tira = @enrachate.current_tira
			 @last_tira = @enrachate.past_tira
			 @future_tira = @enrachate.future_tira
			 @tickets_for_enrachate = EnrachateUser.where("enrachates_id = ?", @enrachate.id).pluck(:enrachate_user_id).uniq
			 @racha_values = []
				@tickets_for_enrachate.each do | ticket |
					@tickets_s = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive")
					@count_ticket = EnrachateUser.where("enrachate_user_id = ? and status = ?",ticket, "alive").count
					last =  @tickets_s.where("tira_enrachate_id = ?", @last_tira.id).count
					current =  @tickets_s.where("tira_enrachate_id = ?", @current_tira.id).count
					if last != 0 || current != 0
					@racha_values.push(@count_ticket)
					end
				end
	end

	def no_sign_in
		render "welcome/terms"
	end

	def ho_we_are
		render "welcome/about"
	end

	def contact
		render "welcome/contact"
	end

	def privacy
		render "welcome/privacy"
	end

	def faq
		render "welcome/faq"
	end



end
