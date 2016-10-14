class RelationTiraQuestion < ActiveRecord::Base
  belongs_to :tira_enrachate
  belongs_to :question_enrachate


  def question_date
    question_enrachate.program_date
  end

end
