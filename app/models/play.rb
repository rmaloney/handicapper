class Play < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	has_one :result

	before_save :default_values

	# Find the result of the game the play was made on. 
	# Update :play_result with Win, Loss or Push
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





	#Helper method to collect user emails and ids for Plays. Used to compute stats, standings, etc.
	def self.emails
		all_plays = Play.where(:status => "Closed")


		 standings = {}
		 #now we loop through the array of user_id/email combos
		 

	end
	
		

	#Callback function sets status of all newly created plays to 'Open'
	def default_values
		self.status ||= 'Open'
	end

	def update_standings

	end
end
