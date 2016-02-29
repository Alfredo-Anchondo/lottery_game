class SportCategorySerializer < ActiveModel::Serializer
  attributes :sport_id, :category_id
    
    has_one :category
    has_one :sport
end
