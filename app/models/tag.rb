class Tag < ActiveRecord::Base
  attr_accessible :name
  belongs_to :photo
  validates :name, presence: true
end
