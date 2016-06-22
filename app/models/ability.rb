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
		can [:index, :show], Survivor do |s|
			user.id == s.user_id
		end
        cannot [:new, :create, :edit, :update, :delete, :destroy], Game
		cannot [:new, :create, :edit, :update, :delete, :destroy], Survivor
		cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorWeekGame
		cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorGame
		cannot [:new, :create, :edit, :update, :delete, :destroy], Quiniela
		cannot [:new, :create, :edit, :update, :delete, :destroy], QuinielaUser
		cannot [:new, :create, :edit, :update, :delete, :destroy], SurvivorUser
		cannot [:new, :create, :edit, :update, :delete, :destroy], QuinielaQuestion
        cannot [:new, :create, :edit, :update, :delete, :destroy], Role
        cannot [:new, :create, :edit, :update, :delete, :destroy], Team
        cannot [:new, :create, :edit, :update, :delete, :destroy], Category
        cannot [:new, :create, :edit, :update, :delete, :destroy], Sport
		cannot [:new, :index, :create, :delete, :destroy], User
        cannot [:new, :create, :edit, :update, :delete, :destroy], SportCategory
        cannot [:new, :create, :edit, :update, :delete, :destroy], Lottery
        cannot [:edit, :update, :delete, :destroy], UserLottery
    end

  end
end
