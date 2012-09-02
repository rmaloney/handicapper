class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  if Rails.env.production?
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  else
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :handle

  has_many :plays
  

  def self.win_loss
  	users = User.all
  	standings = {}
  	users.each do |user|
  		plays = user.plays
  		wins = plays.select {|p| p.play_result == "Win"}.length
  		losses = plays.select {|p| p.play_result == "Loss"}.length

  		puts "User #{user.email} has " + plays.length.to_s + " plays\n"
  		puts "User #{user.email} has " + wins.to_s + " wins\n"
  		puts "User #{user.email} has " + losses.to_s + "losses"

  	end		

  end


  #checks to see if a user has a play on the existing game
  def has_play?(game)
    plays = self.plays.find_all_by_game_id(game)
    if plays.length > 0
      plays
    else
      false
    end
  end

  #returns total number of wins
  def wins
    self.plays.select {|p| p.play_result == "Win"}.length
  end

  #returns total number of losses
  def losses
    self.plays.select{|p| p.play_result == "Loss"}.length
  end

  def pushes
    self.plays.select{|p| p.play_result == "Push"}.length
  end

  # trends
   
   def total_plays
     self.plays.where(:status => "Closed").length
   end

   def favorites
    self.plays.where(:selection => "Favorite").length
   end

   def underdogs
    self.plays.where(:selection => "Underdog").length
   end

   def overs
     self.plays.where(:selection => "Over").length
   end

   def unders
     self.plays.where(:selection => "Under").length
   end

   
    
   
  
end
