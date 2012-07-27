class Play < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	has_one :result

	#callbacks
	before_create :default_values

	#validation
	validates :selection, :uniqueness => {:scope => [:game_id, :user_id]}
	validates :selection, :presence => true
	validate :cannot_have_more_than_6_plays

	#scopes
	scope :closed, where(:status => "Closed")
	scope :open, where(:status => "Open")
	scope :instanceplays, lambda {|user| where("plays.instance_id = ?", user.instance_id)}
	
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
		 standings = {}
		 #now we loop through the array of user_id/email combos
	end
	
		

	#Callback function sets status of all newly created plays to 'Open'
	def default_values
		self.status ||= 'Open'
	end

	#Validation to ensure user cannot have more than 6 open plays

	def cannot_have_more_than_6_plays
		open_plays = Play.where("status = ? AND user_id = ?", "Open", user_id)
		
		if open_plays.count >= 6
			errors.add(:selection, "You already have 6 open plays")
		end
	end

	def update_standings

	end
end
