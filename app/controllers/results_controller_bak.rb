class ResultsController < ApplicationController
	
	def index
	    @result = Result.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @results }
	    end
	end


	def create
	 	@result =Result.new(params[:result])

	 	respond_to do |format|
	 		if @play.save
		        format.html { redirect_to [@result], :notice => 'Result saved' }
		        format.json { render json: @result, status: :created, location: @result }
		     else
		        format.html { render action: "new" }
		        format.json { render json: @result.errors, status: :unprocessable_entity }
			end
      	end
  	end




end
