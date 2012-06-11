class PlaysController < ApplicationController

	before_filter :get_game, :except => :index

	def index
	    @plays = Play.find_all_by_user_id(current_user.id)
	   
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @plays }
	    end
	end


	def new
	 	
	 	@play = @game.plays.build

	 	respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @play }
    	end
	end

	def create
	 	@play = @game.plays.build(params[:play])

	 	respond_to do |format|
	 		if @play.save
		        format.html { redirect_to [@game, @play], :notice => 'Play was successfully created.' }
		        format.json { render json: @play, status: :created, location: @play }
		     else
		        format.html { render action: "new" }
		        format.json { render json: @play.errors, status: :unprocessable_entity }
			end
      	end
  	end

  	def show
  		@play = @game.plays.find(params[:id])

  		respond_to do |format|
  			format.html 
  		end
  	end


  	private

  	def get_game
  		@game = Game.find(params[:game_id])
  	end
end
