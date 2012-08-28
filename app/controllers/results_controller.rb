class ResultsController < ApplicationController
	
	def index
	    @results = Result.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @results }
	    end
	end


	def create
	 	@result =Result.new(params[:result])

	 	respond_to do |format|
	 		if @result.save
		        format.html { redirect_to [@result], :notice => 'Result saved' }
		        format.json { render json: @result, status: :created, location: @result }
		     else
		        format.html { render action: "new" }
		        format.json { render json: @result.errors, status: :unprocessable_entity }
			end
      	end
  	end

  	def new
	 
	 	#@game = Game.find(session[:game_id])
	 	@result = Result.new
	 	@game = Game.find(session[:game_id])

	 	respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @result }
    	end
	end

	def show
  		@result = Result.find(params[:id])

  		respond_to do |format|
  			format.html 
  			format.json { render json: @result }
  		end
  	end

  	def standings
  		@standings = []

  		User.all.each do |u|
  			if u.plays.any? {|p| p.status == "Closed"}
	  			@standings << [u.handle, u.wins, u.losses, u.pushes]
	  			@standings = @standings.sort_by{|x| -(x[1] / (x[1] + x[2]).to_f)}
	  		end
  		end
	end

end
