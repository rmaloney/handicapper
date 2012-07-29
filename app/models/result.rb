class Result < ActiveRecord::Base
	belongs_to :game
	belongs_to :play
	
	after_create :update_plays

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




	protected

	def update_plays
		plays = Play.find_all_by_game_id(game_id)
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

			p.status = 'Closed'
		end
	end
	
	
end
