class Ability
  include CanCan::Ability

  def initialize(user)
        user ||= User.new
    if user.role.is_admin? 
      can :manage, :all
 
    elsif user.role.is_client?
		can [:edit, :update], User do |u|
			user.id == u.id
		end
        cannot [:new, :create, :edit, :update, :delete, :destroy], Game
		cannot [:new, :create, :edit, :update, :delete, :destroy], Quiniela
		cannot [:new, :create, :edit, :update, :delete, :destroy], QuinielaQuestion
        cannot [:new, :create, :edit, :update, :delete, :destroy], Role
        cannot [:new, :create, :edit, :update, :delete, :destroy], Team
        cannot [:new, :create, :edit, :update, :delete, :destroy], Category
        cannot [:new, :create, :edit, :update, :delete, :destroy], Sport
		cannot [:new, :index, :create, :delete, :destroy], User
        cannot [:new, :create, :edit, :update, :delete, :destroy], SportCategory
        cannot [:new, :create, :edit, :update, :delete, :destroy], Lottery
    end

  end
end
