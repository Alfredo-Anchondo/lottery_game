class Category < ActiveRecord::Base
    
      #Associations
    has_attached_file :logo,
    :styles => { :medium => "x300",
    :mobile => "x240" },
    :default_url => "no-image.png"
	
	has_attached_file :background
    
    #Validations
	validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/
    
    #Validations
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  
    
     def select_display
      name
    end
    
end
