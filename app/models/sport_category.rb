class SportCategory < ActiveRecord::Base
  belongs_to :sport
  belongs_to :category
    
     def select_display
         sport.name + ' - '  + category.name
    end
end
