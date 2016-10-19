class Enrachate < ActiveRecord::Base
    has_many :relation_enrachate_tiras
    has_many :tira_enrachates, :through => :relation_enrachate_tiras
    has_many :enrachate_users


    def already_start_question
     day_tira = TiraEnrachate.where("program_date >= ? and program_date <= ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
     RelationTiraQuestion.where("tira_enrachate_id = ?",day_tira.id).each do |relation|
      if relation.question_enrachate.program_date < DateTime.now
        return true
      end
     end
     return false
    end

    def  purchase_tickets_number
      EnrachateUser.where("enrachates_id = ?",id).pluck(:enrachate_user_id).uniq.count
    end


    def current_tira
        @day_tira = ""
        relation_enrachate_tiras.each do |relation|
          if type_enrachate == 1 && initial_date > Time.now
            if relation.tira_enrachate.program_date.to_date == initial_date.to_date
                @day_tira = relation.tira_enrachate
            end
          else
            if relation.tira_enrachate.program_date.to_date == Time.now.to_date
                @day_tira = relation.tira_enrachate
            end
          end
        end
        return @day_tira
    end

    def register_users
      @current_tira = current_tira
      @last_tira = past_tira
      @recent_buy_ticket_enrachate = EnrachateUser.where(" enrachates_id = ? and tira_enrachate_id = ? and status != ? ",  id, @current_tira.id, "loser" )
      if   @last_tira != "" && @last_tira != [] && @last_tira != nil

        @last_day_ticket = EnrachateUser.where("status = ? and enrachates_id = ? and tira_enrachate_id = ? ",  "alive", id, @last_tira.id )
        @a = @recent_buy_ticket_enrachate.pluck(:enrachate_user_id)
        @b = @last_day_ticket.pluck(:enrachate_user_id)

        @new_purchases = (@a - @b).count
      end






      return    @last_day_ticket != nil &&   @last_day_ticket != "" &&   @last_day_ticket != [] ? type_enrachate == 0 ? @last_day_ticket.count + @new_purchases : @last_day_ticket.count   :   @recent_buy_ticket_enrachate != [] && @recent_buy_ticket_enrachate != nil && @recent_buy_ticket_enrachate != "" ?   @recent_buy_ticket_enrachate.count : 0
    end

    def past_tira
        @day_tira = ""
        relation_enrachate_tiras.each do |relation|
            if relation.tira_enrachate.program_date.to_date == Time.now.yesterday.to_date
                @day_tira = relation.tira_enrachate
            end
        end
        return @day_tira
    end

     def future_tira

        @day_tira = ""
        relation_enrachate_tiras.each do |relation|
          if initial_date > Time.now
              @day_tira = ""
          else
            if relation.tira_enrachate.program_date.to_date == Time.now.tomorrow.to_date
                @day_tira = relation.tira_enrachate
            end
          end
        end
        return @day_tira
    end




end
