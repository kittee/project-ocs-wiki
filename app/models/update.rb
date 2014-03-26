class Update < ActiveRecord::Base
  attr_accessible :article_id, :content, :user_id
  
  belongs_to :article
  belongs_to :user

  validates :content, :presence => true
end
