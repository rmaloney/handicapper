class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)

		if user.admin?
			can :manage, Game
			can [:read,:update,:destroy], Play, :user_id => user.id
		else
			can :create, [Play, User]
			can [:read,:update, :destroy], Play, :user_id => user.id
			can :read, Game
		end
	end

end