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

	def default_values
		self.status ||= 'Open'
	end
end
