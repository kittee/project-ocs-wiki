class Categories < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :articles
  
  validates name, :presence => true
end
