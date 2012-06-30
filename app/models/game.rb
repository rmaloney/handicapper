class Game < ActiveRecord::Base

	validates :line, :home_team, :visitor_team, :favorite, :total, :presence => true
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

end
