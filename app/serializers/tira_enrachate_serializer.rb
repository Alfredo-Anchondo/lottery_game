class TiraEnrachateSerializer < ActiveModel::Serializer
  attributes :id, :program_date, :name
    has_many :relation_tira_questions
end
