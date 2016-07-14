class PickUserGame < ActiveRecord::Base
  belongs_to :pick_user
  belongs_to :team
  belongs_to :survivor_game
end
