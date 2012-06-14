class SessionsController < ApplicationController
	#before_filter :current_user, :only => ['destroy']

  def create
		user_name = params[:user_name]
		password = params[:password]
		@user = User.find_by_user_name(user_name)
		if !@user.nil? && @user.authenticate(password)
			session[:user_id]=@user.id
			redirect_to albums_path, notice: "You are now logged in"
		else
			flash[:notice]="Invalid User Name or Password"
			render 'new'
		end
	end
	def destroy
	  session[:user_id] = nil
	  redirect_to '/login'
	end
end
