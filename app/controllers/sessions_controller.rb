class SessionsController < ApplicationController

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
	  redirect_to login_path
	end
	
	def forgot_password_lookup_email
		user = User.find_by_email_id(params[:email_id])
		if user
      user.send_forgot_password!
      flash[:notice] = "A link to reset your password has been mailed to you."
      redirect_to login_path
    else
    	redirect_to reset_password_path, notice: "Email Id you provided doesn't exists."
    end
	end
	
end
