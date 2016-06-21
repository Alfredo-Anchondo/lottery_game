class Team2Serializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sport_category_id, :created_at, :logo_url, :logo_file_name
end
