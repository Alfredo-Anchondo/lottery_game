class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sport_category_id, :created_at, :logo_url
end
