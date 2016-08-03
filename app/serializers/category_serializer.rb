class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :logo, :background, :logo_url, :background_url
end
