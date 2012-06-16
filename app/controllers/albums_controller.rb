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
  	if !params[:album][:photos_attributes].nil?
			params[:album][:photos_attributes].each do|k,v|
				tags = v[:tags].split(',')
				tags.inject([]){|result , h| result << h.strip!}# if (h.strip.empty?)}
				tags.reject!{|c| c.strip.empty?} 
				tags.uniq!
				arr = []
				tags.each do |tag| arr << Tag.find_or_create_by_name(:name => tag) end
				v[:tags] = arr
			end
		end
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
  	if !params[:album][:photos_attributes].nil?
			params[:album][:photos_attributes].each do|k,v|
				tags = v[:tags].split(',')
				tags.inject([]){|result , h| result << h.strip!}# if (h.strip.empty?)}
				tags.reject!{|c| c.strip.empty?} 
				tags.uniq!
				arr = []
				tags.each do |tag| arr << Tag.find_or_create_by_name(:name => tag) end
				v[:tags] = arr
			end
		end
  	if @album.belongs_to_current_user?(current_user) && @album.update_attributes(params[:album])
  		redirect_to albums_path, notice: "Album updated successfully."
  	else
  		flash[:notice] = "Album not updated"
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
