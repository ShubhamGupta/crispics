class Album < ActiveRecord::Base
	attr_accessible :title, :photos_attributes
  belongs_to :user
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
  validates :title, presence: true 
  def belongs_to_current_user?(curr_user)
  	self.user_id == curr_user.id
  end 
  def add_a_photo
  	self.photos.build
  end
  
end
