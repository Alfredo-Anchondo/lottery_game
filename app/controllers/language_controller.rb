class LanguageController < ApplicationController 
    
  def i18n
    I18n.locale = search_profile
     redirect_to :back
      rescue ActionController::RedirectBackError
      redirect_to :root
      
  end
    

     def search_profile
        @user = current_user
        if @user
            if @user.language != "" || nil
                logger.info "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&Si entro $$$$$$$$$$$$$$$$$$$$$$$"
                return @user.language
            else    
                logger.info "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Agarro default %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
                return params[:locale] 
            end  
        else
            return params[:locale] 
        end
    end
    
end