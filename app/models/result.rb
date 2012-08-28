class Result < ActiveRecord::Base
	belongs_to :game
	belongs_to :play
	
	after_save :update_plays

	#checks to see if result ATS was favorite, underdog, or push
	def line_result
		line = self.game.line
		result = favorite_score - underdog_score
		if result > line
			"Favorite"
		elsif result < line
			"Underdog"
		else
			"Push"
		end
	end

	#checks to see if result for over/under was over, under or push
	def total_result
		total = self.game.total
		result = favorite_score + underdog_score
		if result > total
			"Over"
		elsif result < total
			"Under"
		else
			"Push"
		end
	end

	def process
		game = self.game
		result = game.result
		choice = self.selection
		resultset = [result.line_result, result.total_result]
		totals = ["Over", "Under"]
		lines = ["Favorite", "Underdog"]
		
		if lines.include?(choice) && resultset[0] == "Push"
			self.update_attributes(:play_result => "Push")  
		elsif totals.include?(choice) && resultset[1] == "Push" 
			self.update_attributes(:play_result => "Push")  
		elsif resultset.include?(choice)
			self.update_attributes(:play_result => "Win") 
			
		else
			self.update_attributes(:play_result => "Loss")	
		end

		self.status = 'Closed'
	end


	#should return an array of hashes with user as key, and wins/losses as values
	# e.g [:ryan=> {:wins => 10, :losses => 6}, :ned => {:wins => 9, :losses 7}]
	
	def self.standings
		plays = Play.closed
		#plays.group(:user_id)

		#puts plays.inspect
		users = plays.map(&:user_id).uniq
		standings = Hash.new{|hash,key| hash[key]=Hash.new(0)}
		puts users.inspect
		users.each do |u|
			plays = Play.closed.where(:user_id => u)

			plays.each do |p|
				if p.play_result == "Win"
					standings[u][:wins] += 1
				elsif p.play_result == "Loss"
					standings[u][:losses] += 1
				end
			end
			puts "User with user_id #{u} has #{standings[u][:wins]} wins and #{standings[u][:losses]} losses"
		end
	end



	protected

	def update_plays
		plays = Play.find_all_by_game_id(self.game_id)
		plays.each do |p|
			choice = p.selection
			resultset = [self.line_result, self.total_result]
			totals = ["Over", "Under"]
			lines = ["Favorite", "Underdog"]
			
			if lines.include?(choice) && resultset[0] == "Push"
				p.update_attributes(:play_result => "Push")  
			elsif totals.include?(choice) && resultset[1] == "Push" 
				p.update_attributes(:play_result => "Push")  
			elsif resultset.include?(choice)
				p.update_attributes(:play_result => "Win") 	
			else
				p.update_attributes(:play_result => "Loss")	
			end

			p.update_attributes(:status => "Closed")
		end
	end
	
	
end
