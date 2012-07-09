class Play < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	has_one :result

	before_save :default_values

	def process
		
		game = self.game
		result = game.result
		choice = self.selection

		resultset = [result.line_result, result.total_result]
		puts resultset.inspect
		# choice = "Under"
		#["Favorite","Under"] OR ["Favorite", "Push"]
		if choice = "Over" || "Under" && resultset[1] = "Push"
			self.play_result = "Push"  
		elsif choice = "Favorite" || "Underdog" && resultset[0] = "Push" 
			self.play_result = "Push" 
		elsif resultset.include?(choice)
			self.play_result = "Win"  
		else
			self.play_result ="Loss"
		end

		self.status = 'Closed'
	end

	def default_values
		self.status ||= 'Open'
	end
end
