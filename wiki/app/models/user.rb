class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :username
  
  has_many :updates
  
  validates :email, :uniqueness => true
  validates :fname, :presence => true
  validates :lname, :presence => true
  validates :username, :uniqueness => true
  validates :username, :format => { :with => /^[a-zA-Z0-9_]+$/ }
  def name
    fname + " " + lname
  end
    
end
