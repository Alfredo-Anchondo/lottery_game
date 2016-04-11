class LanguageController < ApplicationController 

    before_action :authenticate_user!
    
  def i18n
    I18n.locale = search_profile
     redirect_to :root
      
  end
    

    private def search_profile
        @user = current_user
        logger.info @user.language
        if @user.language != "" || nil
            return @user.language
        else    
            return params[:locale]
        end    
    end
    
end