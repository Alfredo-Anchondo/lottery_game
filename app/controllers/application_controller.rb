class ApplicationController < ActionController::Base
    include ApplicationHelper   
  before_filter :configure_permitted_parameters, if: :devise_controller?
    before_action :change_language    
    
    
  protected
    
    def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |params|
    params.permit(
        :email, :password, :password_confirmation, :name, :address_1, :address_2, :zip_code, :cellphone,:role_id, :country, :username,
      :last_name
    )
  }
  devise_parameter_sanitizer.for(:account_update) { |params|
    params.permit(
      :email, :password, :password_confirmation, :name,
      :last_name
    )
  }
end
    
    
    def change_language
        if current_user.language
        I18n.locale = current_user.language
        end
    end
    
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
