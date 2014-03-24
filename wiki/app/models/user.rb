class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :username
  
  has_many :updates
  
  validates :email, :uniqueness => true
  validates :fname, :presence => true
  validates :lname, :presence => true
  validates :username, :uniqueness => true
  
  def name
    fname + " " + lname
  end
  
end
