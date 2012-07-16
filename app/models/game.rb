class Game < ActiveRecord::Base

	validates :home_team, :visitor_team,  :presence => true
	has_one :result
	has_many :plays
	
	TEAMS = [
		'NY Giants',
		'Philadelphia',
		'Washington',
		'Dallas',
		'Atlanta',
		'New Orleans',
		'Tampa Bay',
		'Carolina',
		'Detroit',
		'Green Bay',
		'Minnesota',
		'Chicago',
		'San Francisco',
		'St. Louis',
		'Seattle',
		'Arizona',
		'New England',
		'NY Jets',
		'Miami',
		'Buffalo',
		'Tennessee',
		'Houston',
		'Jacksonville',
		'Indianapolis',
		'Baltimore',
		'Pittsburgh',
		'Cinncinati',
		'Cleveland',
		'San Diego',
		'Denver',
		'Oakland',
		'Kansas City'
	]

	#Date ranges for all 17 weeks.
	#Allows app to calculate the current week we are in
	def current_week

	end 
	#determines the underdog of the game
	def underdog
	    if home_team != favorite
	        home_team
	    else
	        visitor_team
	    end
	end

	#returns a concatanated title for the game
	def game_title
		"#{home_team} vs. #{visitor_team}"
	end

	#formats underdog and favorite correctly in views (Capitalizes if home team)
	def index_favorite
		if home_team == favorite
	        home_team.upcase
	    else
	    	favorite
	    end
	end

	def index_underdog
		if home_team == underdog
	        underdog.upcase
	    else
	    	underdog
	    end
	end

	#team logos
	def home_team_logo
		self.home_team + ".jpg"
	end

	def visitor_team_logo
		self.visitor_team + ".jpg"
	end


end
