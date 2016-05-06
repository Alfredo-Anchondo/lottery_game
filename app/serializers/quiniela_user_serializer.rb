class QuinielaUserSerializer < ActiveModel::Serializer
	attributes :id, :ticket_number, :purchase_date
	has_one :user
	has_one :quiniela
end
