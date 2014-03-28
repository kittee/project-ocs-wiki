class User < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :username
  
  has_secure_password
  
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :username
    
  has_many :updates
  
  
  validates :email, :uniqueness => true
  validates :fname, :presence => true
  validates :lname, :presence => true
  validates :username, :uniqueness => true, :format => { :with => /^[a-zA-Z0-9_]+$/ }
  
  def name
    fname + " " + lname
  end

end
