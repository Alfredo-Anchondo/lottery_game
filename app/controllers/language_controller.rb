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
                return @user.language
            else    
                #return params[:locale] 
				return 'es'
            end  
        else
            #return params[:locale] 
			return 'es'
        end
    end
    
end