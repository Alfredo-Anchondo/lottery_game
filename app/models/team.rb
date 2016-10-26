  class Team < ActiveRecord::Base
  #Associations
  belongs_to :sport_category
  has_attached_file :logo,
  :styles => { :medium => "x300",
  :mobile => "x240" },
  :default_url => "no-image.png",
  :url => "/system/teams/:attachment/:id_partition/:style/:filename"

  #Validations
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  validates :name, :uniqueness => { :case_sensitive => false }

  def select_display
    name
  end

  def logo_url
    logo.url
  end

    def played_games
        SurvivorGame.where("team_id = ?  AND winner_team IS NOT NULL",id).count +  SurvivorGame.where("team2_id = ?  AND winner_team IS NOT NULL",id).count
    end

    def won_games
         SurvivorGame.where("winner_team = ? AND local_score != visit_score ",id).count
    end

    def losed_games
           SurvivorGame.where("team_id = ?  AND winner_team != ? AND local_score != visit_score",id,id).count +  SurvivorGame.where("team2_id = ?  AND winner_team != ? AND local_score != visit_score",id,id).count
    end

    def draw_games
        SurvivorGame.where("team_id = ?  AND local_score = visit_score",id).count +  SurvivorGame.where("team2_id = ?  AND local_score = visit_score",id).count
    end

end
