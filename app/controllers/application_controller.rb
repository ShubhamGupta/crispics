class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
  	User.where(:id => session[:user_id]).first
  end
  
  def login_required
  	redirect_to login_path if session[:user_id].nil? 
  end
  
end
