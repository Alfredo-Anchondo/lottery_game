class ApplicationController < ActionController::Base
     include ApplicationHelper
	 before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :change_language
	before_filter do
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)
end
	 respond_to :html
  	 respond_to :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.




	if Rails.env == 'production'
    rescue_from StandardError do |exception|
      process_exception(exception)
		respond_to do |format|
			format.html { redirect_to (request.referer || :root), alert: 'Ocurrio un error, se a reportado al administrador de la pagina.' }
			logger.info exception
      format.json { head :no_content }
    end

    end

    rescue_from ActiveRecord::DeleteRestrictionError do |exception|
      process_exception(exception)
		respond_to do |format|
			format.html { redirect_to (request.referer || :root), alert: 'Ocurrio un error al intentar eliminar un registro. ' }
			logger.info exception
      format.json { head :no_content }
    end
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      process_exception(exception)
		respond_to do |format|
			format.html { redirect_to (request.referer || :root), alert: 'No se encontro el archivo solicitado.' }
			logger.info exception
      format.json { head :no_content }
    end
    end

    rescue_from CanCan::AccessDenied do |exception|
      process_exception(exception)
	respond_to do |format|
		format.html { redirect_to (request.referer || :root), alert: 'No tienes permisos para acceder a esta pagina.' }
		logger.info exception
      format.json { head :no_content }
    end
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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :uid, :password_confirmation, :name, :address_1, :address_2, :zip_code, :cellphone,:role_id, :country, :username,:last_name, :friend_reference, :gift_credit])
#  devise_parameter_sanitizer.permit(:sign_up) { |params|
#    params.permit(
#        :email, :password, :uid, :config_name, :confirm_success_url, :password_confirmation, :name, :address_1, :address_2, :zip_code, :cellphone,:role_id, :country, :username,:last_name, :friend_reference, :gift_credit
#    )
#  }
  devise_parameter_sanitizer.permit(:account_update) { |params|
    params.permit(
      :email, :password, :password_confirmation, :name, :gift_credit, :last_name
    )
  }
end


  #  def change_language
  #      if current_user
  #      I18n.locale = current_user.language
  #      end
  #  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :null_session
end
