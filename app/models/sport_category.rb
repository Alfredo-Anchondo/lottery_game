class SportCategory < ActiveRecord::Base
  belongs_to :sport
  belongs_to :category

  validates :sport_id, :uniqueness => { :scope => [:category_id] }

     def select_display
         sport.name + ' - '  + category.name
    end
end
