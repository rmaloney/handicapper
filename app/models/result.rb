class Result < ActiveRecord::Base
	belongs_to :game
	belongs_to :play
	

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
	
end
