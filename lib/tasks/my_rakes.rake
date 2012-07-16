   desc "Import games." 
		task :import_games => :environment do
			games = File.open("nfl_2012.txt", "r").map do |line|
				start_date,week,kickoff,visitor_team, home_team, status, favorite, line, total = line.strip.split("\t")            
				Game.new(:start_date => start_date, :week => week, :kickoff => kickoff,  :visitor_team => visitor_team, :home_team => home_team, :status => status, :favorite => favorite, :line => line, :total => total)
		  end
	 Game.import games
  end
  

  
  