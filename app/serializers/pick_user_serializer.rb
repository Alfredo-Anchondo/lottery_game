class PickUserSerializer < ActiveModel::Serializer
  attributes :id, :points, :local_score, :visit_score
  has_one :user
  has_one :pick_survivor_week
  has_one :pick_user
end
