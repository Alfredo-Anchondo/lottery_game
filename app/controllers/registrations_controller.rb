class RegistrationsController < Devise::RegistrationsController

  def create
	  build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
		 if @user.reference_by_friend != nil && @user.reference_by_friend != ""
		  logger.info "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NO maaaaa %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
		  x = User.search_reference1(@user.reference_by_friend)
		    logger.info x
		  	if @user.gift_credit == nil
				last = 0
		  	else
				last = Integer(@user.gift_credit)
		  	end
			 
		    @user1 = User.find(x)
		 
		  	if @user1[0].gift_credit == nil
				last1 = 0
		  	else
				last1 = Integer(@user1[0].gift_credit)
		  	end
		  @user1[0].update( :gift_credit => last1 +10)
		   @user.update( :gift_credit =>  last + 10) 
		  logger.info @user1
		  logger.info @user.gift_credit
		  logger.info @user1[0].gift_credit 
	  end
		
    BuyMailer.welcome_user(@user).deliver
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
	
	protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name, :gender, :balance, :username, :password, :role_id, :birthday, :reference_by_friend, :friend_reference, :gift_credit)
  end
	
end
