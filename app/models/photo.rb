class Photo < ActiveRecord::Base

	attr_accessible :pic	, :tags
	
  belongs_to :album
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "50x50>" },
  	:path => ":rails_root/public/system/:attachment/:id/:style/:filename", 
  :url => "/system/:attachment/:id/:style/:filename"
#validates :pic_file_name, presence: true
 	validates_format_of :pic_file_name, :with => %r{\.(jpeg|gif|jpg)$}i
#  validates_attachment_size :picture, :less_than => 1.megabytes 
  def belongs_to_current_album?(album, curr_user)
  	album.belongs_to_current_user?(curr_user) && self.album_id == album.id
  end
  
end
#ffaker
#shouldamatcher # validations
#machinist
#factory girl

