require 'open-uri'
require 'nokogiri'

URL_MAP = {
		'Dallas' => 'http://espn.go.com/nfl/team/_/name/dal/dallas-cowboys',
		'NY Giants' => 'http://espn.go.com/nfl/team/_/name/nyg/new-york-giants',
		'Philadelphia' => 'http://espn.go.com/nfl/team/_/name/phi/philadelphia-eagles',
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




def home_stats(home_team)
		home_url = URL_MAP[home_team]
		doc = Nokogiri::HTML(open(home_url))
		# Fetch stats. 
		# Nokogiri will scrape stats for yards and ranks and place them into an 
		# 1 =>Pass yd # 2 =>Rush Yards # 3 =>Opp Pass Yards 	# 4 => Opp Rush Yards
		yards = []
		ranks = []
		
		doc.css("div.mod-content > span").each do |h|
			yards << h.text
		end

		#fetch NFL ranks for each stat
		doc.css("div.mod-content > strong").each do |h|
			ranks << h.text
		end

		final = yards.zip(ranks)
end

puts home_stats('NY Giants').class