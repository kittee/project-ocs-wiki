class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  attr_accessible :title, :updates_attributes, :category_ids
  
  has_and_belongs_to_many :categories
  has_many :updates
  accepts_nested_attributes_for :updates
  
  validates :title, :uniqueness => true
  validates :title, :presence => true
  validates :title, :format => { :with => /^[a-zA-Z0-9 ]+$/ }
end
