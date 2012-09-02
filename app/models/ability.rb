class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)

		if user.admin?
			can [:manage,:schedule], Game
			can :manage, Result
			can :manage, Post
			can [:create, :read,:update,:destroy, :trends], Play, :user_id => user.id
		else
			can :schedule, Game
			can :read, Game
			can [:create, :read,:update, :destroy, :trends], Play, :user_id => user.id
			can :read, Play, :status => "Closed"
			can :manage, User, :user_id => user.id	
		end
	end

end