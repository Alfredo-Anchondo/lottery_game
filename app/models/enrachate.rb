class Enrachate < ActiveRecord::Base
    has_many :relation_enrachate_tiras
    has_many :tira_enrachates, :through => :relation_enrachate_tiras
    has_many :enrachate_users


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
      EnrachateUser.where("enrachates_id = ?",id).pluck(:user_id).uniq.count
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
            if relation.tira_enrachate.program_date.to_date == Time.now.tomorrow.to_date
                @day_tira = relation.tira_enrachate
            end
        end
        return @day_tira
    end




end
