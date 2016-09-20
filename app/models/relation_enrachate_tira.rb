class RelationEnrachateTira < ActiveRecord::Base
  belongs_to :enrachate
  belongs_to :tira_enrachate
end
