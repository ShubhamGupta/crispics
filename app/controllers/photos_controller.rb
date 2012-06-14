class PhotosController < ApplicationController
	before_filter :login_required
		
	def show
		@photo = Photo.find(params[:id])	
	end
	def destroy
		Photo.find(params[:id]).destroy
		respond_to do |format|
			format.js
		end
	end
end
