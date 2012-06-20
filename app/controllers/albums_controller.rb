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
  	process_params if !params[:album][:photos_attributes].nil?
		@album = Album.new params[:album]
  	@album.user_id = current_user.id
  	if @album.save
  		redirect_to albums_path, notice: "Album created"
  	else
  		@album.photos = []
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
  	process_params if !params[:album][:photos_attributes].nil?
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

  
  def process_params 
  	params[:album][:photos_attributes].each do|k,v|
  		if v.has_key?(:pic)
				tags = v[:tags].split(',')
				tags.inject([]){|result , h| result << h.strip! if (v[:pic])}
				tags.reject!{|c| c.strip.empty?} 
				tags.uniq!
				arr = []
				tags.each do |tag| arr << Tag.find_or_create_by_name(:name => tag) end
				v[:tags] = arr
			else
				params[:album][:photos_attributes].delete(k)
			end
		end
	end

  def get_album_from_params
  	@album = Album.find params[:id]
  end

  def redirect_if_not_found
  	redirect_to albums_path, notice: "Album not found"
  end

end
