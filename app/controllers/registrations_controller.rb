class RegistrationsController < Devise::RegistrationsController

  def create
	super
	  if @user.reference_by_friend != nil
		  logger.info "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NO maaaaa %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
		  x = User.search_reference1(@user.reference_by_friend)
		  if @user.gift_credit == nil
			  last = 0
		  else
			  last = Integer(@user.gift_credit)
		  end
		 
		  @user.update( :gift_credit =>  last + 10)
		    @user1 = User.find(x)
		  logger.info @user1[0].gift_credit
		  if @user1[0].gift_credit == nil
			  last1 = 0
		  else
				last1 = Integer(@user1[0].gift_credit)
		  end
		  @user1[0].update( :gift_credit => last1 +10)
		   
		  logger.info x
		  logger.info @user1
		  logger.info @user.gift_credit
		  
	  end
    BuyMailer.welcome_user(@user).deliver
  end
	
	protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name, :gender, :balance, :username, :password, :role_id, :birthday, :reference_by_friend)
  end
	
end
