class LanguageController < ApplicationController 

    before_action :authenticate_user!
    
  def i18n
    return if params[:locale].blank?
    I18n.locale = search_profile
    redirect_to :back
  end
    

    private def search_profile
        @user = current_user
        if @user.language
            return @user.language
        else    
            return params[:locale]
        end    
    end
    
end