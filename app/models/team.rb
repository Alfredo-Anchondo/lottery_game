class Team < ActiveRecord::Base
    
          #Associations
    belongs_to :sport_category
    has_attached_file :logo,
    :styles => { :medium => "x300",
    :mobile => "x240" },
    :path => "rails_root/public/system/:class/:attachment/:id/:style/:filename",
    :url => "/system/:class/:attachment/:id/:style/:filename",
    :default_url => "no-image.png"
    
    #Validations
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  

    
      def select_display
      name
    end
    
end
