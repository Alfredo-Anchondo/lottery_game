class RelationTiraQuestionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :question_enrachate
end
