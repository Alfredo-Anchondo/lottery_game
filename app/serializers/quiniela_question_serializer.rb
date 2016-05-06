class QuinielaQuestionSerializer < ActiveModel::Serializer
	attributes :id, :value, :quiniela_id
	has_one :question
end
