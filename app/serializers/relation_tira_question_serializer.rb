class RelationTiraQuestionSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :question_enrachate
end
