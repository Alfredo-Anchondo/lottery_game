class RelationTiraQuestion < ActiveRecord::Base
  belongs_to :tira_enrachate
  belongs_to :question_enrachate
end
