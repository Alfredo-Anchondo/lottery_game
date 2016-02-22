class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role.is_admin? 
      can :manage, :all
 
    elsif user.role.is_client?
      can :manage, :all
        cannot [:new, :create, :edit, :update, :delete, :destroy], Game
        cannot [:new, :create, :edit, :update, :delete, :destroy], Role
        cannot [:new, :create, :edit, :update, :delete, :destroy], Team
        cannot [:new, :create, :edit, :update, :delete, :destroy], Category
        cannot [:new, :create, :edit, :update, :delete, :destroy], Sport
        cannot [:new, :create, :edit, :update, :delete, :destroy], User
        cannot [:new, :create, :edit, :update, :delete, :destroy], SportCategory
        cannot [:new, :create, :edit, :update, :delete, :destroy], Lottery
        cannot [:new, :create, :edit, :update, :delete, :destroy], UserLottery
    end
    #cannot [:new, :create, :delete, :destroy], Report50Template
  end
end
