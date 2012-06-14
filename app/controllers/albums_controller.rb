class AlbumsController < ApplicationController
	before_filter :login_required
	before_filter :get_album_from_params, :only => ['show', 'destroy', 'edit', 'update']
	rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  def new
  	@album = Album.new
  end

  def edit
  	if !@album.belongs_to_current_user?(current_user)
  		redirect_to albums_path, notice: "Album not found"
  	end
  end

  def create
  	@album = Album.create params[:album]
  	@album.user_id = current_user.id
		if @album.save
  		redirect_to albums_path(@album), notice: "Album created"
  	else
  		flash[:notice] = "Changes not saved."
  		render 'new'
  	end
  end

  def destroy
  	if @album.belongs_to_current_user?(current_user)
  		@album.destroy
  		flash[:notice] = "Album deleted successfully" 
  	end
  	redirect_to albums_path
  end

  def update
  	if @album.belongs_to_current_user?(current_user) && @album.update_attributes(params[:album])
  		redirect_to albums_path, notice: "Album updated successfully."
  	else
  		render 'edit'
  	end
  end

  def show
  	if !@album.belongs_to_current_user?(current_user)
  		redirect_to albums_path, notice: "Album not found"
  	end
  end

  def index
  	@albums = current_user.albums
  end
  
  private
  def get_album_from_params
  	@album = Album.find params[:id]
  end
  def redirect_if_not_found
  	redirect_to albums_path, notice: "Album not found"
  end
end
