class ApplicationController < ActionController::Base
    include ApplicationHelper   
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :change_language    
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 

	if Rails.env == 'production' || Rails.env == 'development' 
    rescue_from StandardError do |exception|
		
		logger.info exception
      process_exception(exception)
      redirect_to (request.referer || :root) 
    end

    rescue_from ActiveRecord::DeleteRestrictionError do |exception|
		logger.info exception
      process_exception(exception)
      redirect_to (request.referer || :root) 
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
		logger.info exception
      process_exception(exception)
      redirect_to (request.referer || :root) 
    end

    rescue_from CanCan::AccessDenied do |exception|
		logger.info exception
      process_exception(exception)
      redirect_to (request.referer || :root) 
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  private

  def process_exception(exception)
    user_id = current_user.id if signed_in?
    line_number = exception.backtrace.to_s.split(':in').first.gsub('["', '')

	  ErrorReport.create(
	  :user_id => user_id,
      :controller_name => controller_name,
      :action_name => action_name,
      :description => exception.to_s,
      :referrer_url => request.referer,
      :original_path => request.original_url,
      :enviroment => Rails.env,
      :error_time => Time.current,
      :line_number => line_number,
      :backtrace => exception.backtrace.to_s
    )
  end
    
  protected
    
    def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |params|
    params.permit(
        :email, :password, :password_confirmation, :name, :address_1, :address_2, :zip_code, :cellphone,:role_id, :country, :username,:last_name, :friend_reference
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
        if current_user
        I18n.locale = current_user.language
        end
    end
    
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
