class EnrachateUserSerializer < ActiveModel::Serializer
  attributes :id, :answer, :status, :purchase_date, :enrachate_user_id
  has_one :question_enrachate
  has_one :tira_enrachate
  has_one :user
end
