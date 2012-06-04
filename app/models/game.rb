class Game < ActiveRecord::Base

	validates :line, :home_team, :visitor_team, :favorite, :total, :presence => true
	
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
end
