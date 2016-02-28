class RegistrationsController < Devise::RegistrationsController

  def create
    super
    BuyMailer.welcome_user(@user).deliver
  end

end
