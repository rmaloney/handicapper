class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)

		if user.admin?
			can :manage, Game
			can [:create, :read,:update,:destroy], Play, :user_id => user.id
		else
			can :schedule, Game
			can :read, Game
			can [:create, :read,:update, :destroy], Play, :user_id => user.id
			can :manage, User, :user_id => user.id	
		end
	end

end