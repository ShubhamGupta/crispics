class User < ActiveRecord::Base
attr_accessible :first_name, :last_name, :email_id, :user_name, :password, :password_confirmation, :password_digest
  has_many :albums, :dependent => :destroy
  validates :email_id, :user_name, uniqueness: true, :length => { :maximum =>255}
	validates :first_name, :email_id, :user_name, presence: true
  has_secure_password
  #validates :password, :length => {:minimum => 6}
  validates_format_of :email_id, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  require 'digest/sha1'
  
  def send_forgot_password!
  	self.reset_perishable_token = Digest::SHA1.hexdigest self.password_digest + self.email_id
  	self.save
  	Notifier.forgot_password(self).deliver
  end
end
