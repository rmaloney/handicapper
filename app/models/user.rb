class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

  has_many :plays
  has_one :user_standing

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
end
