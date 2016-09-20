class EnrachateUserSerializer < ActiveModel::Serializer
  attributes :id, :answer, :status, :purchase_date
  has_one :question_enrachate
  has_one :tira_enrachate
  has_one :user
end
