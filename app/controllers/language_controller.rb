class LanguageController < ApplicationController 

    before_action :authenticate_user!
    
  def i18n
    I18n.locale = search_profile
      if :back
    redirect_to :back
      else
     redirect_to :root
      end
  end
    

    private def search_profile
        @user = current_user
        logger.info @user.language
        if @user.language
            return @user.language
        else    
            return params[:locale]
        end    
    end
    
end