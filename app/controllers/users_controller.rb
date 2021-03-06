class UsersController < ApplicationController
	before_filter :login_required, :only => ['show', 'edit', 'update','destroy']  
  
  def show
		@user = current_user
  end
  
	def reset_password
		@user = User.find_by_reset_perishable_token(params[:secret_token])
		redirect_to login_path, notice: "Please login to access!" if !@user
	end
	
	def update_password
		@user = User.find(params[:format])
		@user.reset_perishable_token = nil
		if @user.update_attributes(params[:user])
			session[:user_id] = @user.id
			redirect_to albums_path
		else
			render :reset_password
		end
	end
	
  def new
    @user = User.new
  end

  def edit
  	@user = current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
    	session[:user_id] = nil
			redirect_to login_path, notice: 'You can now login with your new account.'	
    else
      render action: "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to albums_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
	  current_user.destroy
	  session[:user_id] = nil
	  redirect_to login_path
  end
end
