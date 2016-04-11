class LanguageController < ApplicationController 

    before_action :authenticate_user!
    
  def i18n
    I18n.locale = search_profile
     redirect_to :back
      rescue ActionController::RedirectBackError
      redirect_to :root
  end
      
  end
    

    private def search_profile
        @user = current_user
        logger.info @user.language
        if @user.language != "" || nil
            logger.info "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&Si entro $$$$$$$$$$$$$$$$$$$$$$$"
            return @user.language
        else    
            logger.info "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Agarro default %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
            return params[:locale]
        end    
    end
    
end