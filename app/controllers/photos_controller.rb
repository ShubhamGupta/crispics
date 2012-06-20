class PhotosController < ApplicationController
	before_filter :login_required
	before_filter :get_photo_from_params, :only => ['show', 'destroy']
	rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
	
	def show
		album = Album.find(params[:album_id])
		redirect_to albums_path and return if !@photo.belongs_to_current_album?(album, current_user)
	end
	
	def destroy
		@photo.destroy
		respond_to do |format|
			format.js
		end
	end
	
	private
	def redirect_if_not_found
		redirect_to albums_path, notice: "Image does not exists."
	end
	
	def get_photo_from_params
  	@photo = Photo.find params[:id]
  end
end
