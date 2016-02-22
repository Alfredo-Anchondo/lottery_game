class Role < ActiveRecord::Base
    def select_display
      name
    end
end
