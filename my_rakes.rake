   desc "Import games." 
		task :import_games => :environment do
			games = File.open("games.txt", "r").map do |line|
				week,home_team,visitor_team,favorite,line,total,kickoff,status = line.strip.split("\t")            
				Game.new(:week => week, :home_team => home_team, visitor_team => visitor_team, :favorite => favorite, :line => line, :total => total, :kickoff => kickoff, :status => status)
		  end
	 Game.import games
  end
  

  
  