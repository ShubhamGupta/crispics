class PhotosController < ApplicationController
	before_filter :login_required
	rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
	def show
		@photo = Photo.find(params[:id])
		album = Album.find(params[:album_id])
		redirect_to albums_path and return if !@photo.belongs_to_current_album?(album, current_user)
	end
	
	def destroy
		Photo.find(params[:id]).destroy
		respond_to do |format|
			format.js
		end
	end
	
	private
	def redirect_if_not_found
		redirect_to albums_path, notice: "Image does not exists."
	end
end
