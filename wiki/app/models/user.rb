class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :fname, :lname, :email, :username, :password_digest, :admin
  
  has_many :updates
  
  validates :fname, :presence => true
  validates :lname, :presence => true
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true
  validates :password_digest, :presence => true
end
