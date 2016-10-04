class QuestionEnrachateSerializer < ActiveModel::Serializer
  attributes :id, :title, :answer1, :answer2, :program_date, :correct_answer
end
