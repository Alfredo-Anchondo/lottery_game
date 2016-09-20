class EnrachateUser < ActiveRecord::Base
  belongs_to :question_enrachate
  belongs_to :tira_enrachate
  belongs_to :user
end
