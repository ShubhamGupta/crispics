class Photo < ActiveRecord::Base
#attr_protected :pic_file_name, :pic_content_type, :pic_file_size, :pic_updated_at
attr_accessible :pic	
	#attr_accessor 
  belongs_to :album
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "50x50>" }

  #has_many :tags, :dependent => :destroy
  #accepts_nested_attributes_for :tags
end
