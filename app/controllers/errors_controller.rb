class ErrorsController < ApplicationController
  
  def routing
    render_404
  end

  def render_404(exception = nil)
    if exception
        logger.info "Rendering 404: #{exception.message}"
  	end

  	render 'errors/404'
  end

end
