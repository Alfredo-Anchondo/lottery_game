class RelationEnrachateTiraSerializer < ActiveModel::Serializer
  attributes :id
     has_one :tira_enrachate
    
end
