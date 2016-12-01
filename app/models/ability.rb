class Ability
  include CanCan::Ability

  def initialize(user)
        user ||= User.new
    if user.role.is_admin?
      can :manage, :all

    elsif user.role.is_client?
		can [:edit, :update], User, :id => user.id
		can [:show, :update, :edit, :new, :create], Survivor, :user_id => user.id
    can [:show, :new, :update, :new, :create], Enrachate, :user_id => user.id
    can [:show, :new, :update, :new, :create], Pick, :user_id => user.id
    can [:new, :create, :edit, :update], EnrachateUser, :user_id => user.id


        cannot [:new, :create, :edit, :update, :delete, :destroy], Game
		    cannot [ :index, :delete, :destroy], Survivor
		    cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorWeekGame
		    cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorGame
		    cannot [:new, :create, :edit, :update, :delete, :destroy], Quiniela
		    cannot [:new, :create, :edit, :update, :delete, :destroy], QuinielaUser
		    cannot [:edit, :update, :delete, :destroy], SurvivorUser
		    cannot [:new, :create, :edit, :update, :delete, :destroy], QuinielaQuestion
        cannot [:new, :create, :edit, :update, :delete, :destroy], Role
        cannot [:new, :create, :edit, :update, :delete, :destroy], Team
        cannot [:new, :create, :edit, :update, :delete, :destroy], Category
        cannot [:new, :create, :edit, :update, :delete, :destroy], Sport
		    cannot [:new, :index, :create, :delete, :destroy], User
        cannot [:new, :create, :edit, :update, :delete, :destroy], SportCategory
        cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorWeekSurvivor
        cannot [ :delete, :destroy], EnrachateUser
        cannot [:new, :create, :edit, :update, :delete, :destroy], Lottery
        cannot [:edit, :update, :delete, :destroy], UserLottery
        cannot [:index, :delete, :destroy], Enrachate
        cannot [:index, :delete, :destroy], Pick

  end

  end
end
