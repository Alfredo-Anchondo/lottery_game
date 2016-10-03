class Enrachate < ActiveRecord::Base
    has_many :relation_enrachate_tiras
    has_many :tira_enrachates, :through => :relation_enrachate_tiras
    has_many :enrachate_users


    def current_tira
        @day_tira = ""
        relation_enrachate_tiras.each do |relation|
            if relation.tira_enrachate.program_date.to_date == Time.now.to_date
                @day_tira = relation.tira_enrachate
            end
        end
        return @day_tira
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
