class PickUserGame < ActiveRecord::Base
  belongs_to :pick_user
  belongs_to :team
  belongs_to :survivor_game
    
  before_save :check_if_repeat      
    

  def check_if_repeat
    exist = PickUserGame.where("survivor_game_id = ? AND pick_user_id = ?", survivor_game.id, pick_user.id)
      logger.info exist
      logger.info "EXIST VALUEEEEEEEEEEEEEEEEEEEEEEEEE"
      
      if exist == "" || exist == [] || exist == nil
          return true
          else
          return false
      end
  end    
    
    
    
end

