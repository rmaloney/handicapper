class PlaysController < ApplicationController

	before_filter :authenticate_user!
	#before_filter :get_game, :except => :index

	def index
	    @plays = Play.find_all_by_user_id(current_user.id)
	    
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @plays }
	    end
	end

	def show
  		@play = Play.find(params[:id])

      
  		respond_to do |format|
  			format.html 
  			format.json { render json: @play }
  		end
  	end

	def new
	 
	 	#@game = Game.find(session[:game_id])
	 	@play = Play.new
	 	@game = Game.find(session[:game_id])

    if current_user.has_play?(@game.id)
      @existing_play = true
    end
	 	respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @play }
    	end
	end

	def create
	 	@play =Play.new(params[:play])

    #do we already have a play for this game?
   

	 	respond_to do |format|
	 		if @play.save
		        format.html { redirect_to [@play], :notice => 'Your play has been created.' }
		        format.json { render json: @play, status: :created, location: @play }
		     else
		        format.html { render action: "new" }
		        format.json { render json: @play.errors, status: :unprocessable_entity }
			end
      	end
  	end

  	def process_results
  		@plays = Play.where(:status => "Open")
  		@plays.each do |play|
  			play.update_result
  		end

  		respond_to do |format|
  			format.html {redirect_to root_url :notice => 'Plays have been processed and standings updated'}
  		end
  	end


  	def destroy
  		@play = Play.find(params[:id])
  		@play.destroy

  		respond_to do |format|
  			format.html {redirect_to(plays_url)}
  			format.json { head :no_content }
  		end
  	end



  	

  	private

  	def get_game
  		@game = Game.find(params[:game_id])
  	end
end
