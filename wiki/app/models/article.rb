class Article < ActiveRecord::Base
  attr_accessible :title
  
  has_and_belongs_to_many :categories
  has_many :updates
  
  validates :title, :uniqueness => true
  validates :title, :presence => true
  validates :title, :format => { :with => /^[a-zA-Z0-9 ]+$/ }
end
