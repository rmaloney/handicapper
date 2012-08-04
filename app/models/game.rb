class Game < ActiveRecord::Base

	require 'open-uri'
	require 'nokogiri'

	validates :home_team, :visitor_team,  :presence => true
	has_one :result
	has_many :plays

	before_create :default_values
	
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

	URL_MAP = {
		'Dallas' => 'http://espn.go.com/nfl/team/_/name/dal/dallas-cowboys',
		'NY Giants' => 'http://espn.go.com/nfl/team/_/name/nyg/new-york-giants',
		'Philadelphia' => 'http://espn.go.com/nfl/team/_/name/phi/philadelphia-eagles',
		'Washington' => 'http://espn.go.com/nfl/team/_/name/wsh/washington-redskins',
		'Arizona' => 'http://espn.go.com/nfl/team/_/name/ari/arizona-cardinals',
		'San Francisco' => 'http://espn.go.com/nfl/team/_/name/sf/san-francisco-49ers',
		'Seattle' => 'http://espn.go.com/nfl/team/_/name/sea/seattle-seahawks',
		'St. Louis' => 'http://espn.go.com/nfl/team/_/name/stl/st-louis-rams',
		'Chicago' => 'http://espn.go.com/nfl/team/_/name/chi/chicago-bears',
		'Detroit' => 'http://espn.go.com/nfl/team/_/name/det/detroit-lions',
		'Green Bay' => 'http://espn.go.com/nfl/team/_/name/gb/green-bay-packers',
		'Minnesota' => 'http://espn.go.com/nfl/team/_/name/min/minnesota-vikings',
		'Atlanta' =>  'http://espn.go.com/nfl/team/_/name/atl/atlanta-falcons',
		'Carolina' => 'http://espn.go.com/nfl/team/_/name/car/carolina-panthers',
		'New Orleans' => 'http://espn.go.com/nfl/team/_/name/no/new-orleans-saints',
		'Tampa Bay' => 'http://espn.go.com/nfl/team/_/name/tb/tampa-bay-buccaneers',
		'Buffalo' => 'http://espn.go.com/nfl/team/_/name/buf/buffalo-bills',
		'Miami' => 'http://espn.go.com/nfl/team/_/name/mia/miami-dolphins',
		'New England' => 'http://espn.go.com/nfl/team/_/name/ne/new-england-patriots',
		'NY Jets' => 'http://espn.go.com/nfl/team/_/name/nyj/new-york-jets',
		'Denver' => 'http://espn.go.com/nfl/team/_/name/den/denver-broncos',
		'Kansas City' => 'http://espn.go.com/nfl/team/_/name/kc/kansas-city-chiefs',
		'Oakland' => 'http://espn.go.com/nfl/team/_/name/oak/oakland-raiders',
		'San Diego' => 'http://espn.go.com/nfl/team/_/name/sd/san-diego-chargers',
		'Baltimore' => 'http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens',
		'Cincinnati' => 'http://espn.go.com/nfl/team/_/name/cin/cincinnati-bengals',
		'Cleveland' => 'http://espn.go.com/nfl/team/_/name/cle/cleveland-browns',
		'Pittsburgh' => 'http://espn.go.com/nfl/team/_/name/pit/pittsburgh-steelers',
		'Houston' => 'http://espn.go.com/nfl/team/_/name/hou/houston-texans',
		'Indianapolis' => 'http://espn.go.com/nfl/team/_/name/ind/indianapolis-colts',
		'Jacksonville' => 'http://espn.go.com/nfl/team/_/name/jac/jacksonville-jaguars',
		'Tennessee' => 'http://espn.go.com/nfl/team/_/name/ten/tennessee-titans'
	}
	
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

	def logo(side)
		side + ".jpg"
	end


	def self.matchup_stats(team)
		url = URL_MAP[team]
		doc = Nokogiri::HTML(open(url))

		# Fetch stats. # 1 =>Pass yd # 2 =>Rush Yards # 3 =>Opp Pass Yards# 4 => Opp Rush Yards
		yards = []
		ranks = []

		doc.css("div.mod-content > span").each do |h|
			yards << h.text
		end

		#fetch NFL ranks for each stat
		doc.css("div.mod-content > strong").each do |h|
			ranks << "(#{h.text})"
		end

		stats = yards.zip(ranks)
		stats.each.map do |s|
			s.join ' '
		end

	end







	def default_values
		self.status ||= 'Current'
	end

end
