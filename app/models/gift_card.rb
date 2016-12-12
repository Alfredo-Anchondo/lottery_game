class GiftCard < ActiveRecord::Base
  belongs_to :user
  validates :code, uniqueness: true
  
end
