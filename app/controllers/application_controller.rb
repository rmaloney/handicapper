class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :catch_not_found, :catch_404

  # rescue_from CanCan::AccessDenied do |exception|
	#  flash[:error] = exception.message
	#  redirect_to root_url
  # end
  
  	

  

	private

	def catch_not_found
	  yield
	rescue ActiveRecord::RecordNotFound
	  redirect_to root_url, :flash => { :error => "Record not found." }
	end

	def catch_404
	  yield
	rescue ActionController::RoutingError
	  redirect_to root_url, :flash => { :error => "Couldn't find that url" }
	end



end
