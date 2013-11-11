class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_check_template(action=params[:action])
    render action, layout: params[:render_template] != 'false'
  end

end