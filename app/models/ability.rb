class Ability
	include CanCan::Ability

	def initialize(user)

		user ||= User.new # guest user (not logged in)

		if user.admin?
			can :manage, :all
		else
			can :create, [Play, User]
			can :update, Play, :user_id => user.id
			can :manage, user
		end
	end
end