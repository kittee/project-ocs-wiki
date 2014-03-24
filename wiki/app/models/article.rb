class Article < ActiveRecord::Base  
  attr_accessible :title
  
  has_and_belongs_to_many :categories
  has_many :updates
  
  validates :title, :uniqueness => true
end
