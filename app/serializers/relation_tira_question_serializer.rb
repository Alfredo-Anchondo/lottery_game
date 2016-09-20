class RelationTiraQuestionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :tira_enrachate
  has_one :question_enrachate
end
