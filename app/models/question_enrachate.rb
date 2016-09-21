class QuestionEnrachate < ActiveRecord::Base
    has_many :relation_tira_questions
    has_many :tira_enrachates,  :through => :relation_tira_questions
    
    after_create :relation_question_tira
    
    
    def relation_question_tira
        
      tiras =  TiraEnrachate.where("program_date > ? and program_date < ?",program_date.beginning_of_day, program_date.end_of_day)
        tiras.each do |tira|
            question = RelationTiraQuestion.new
            question.tira_enrachate_id = tira.id
            question.question_enrachate_id = id
            question.save
        end
        
    end
    
end
