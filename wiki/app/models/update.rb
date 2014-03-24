class Update < ActiveRecord::Base  
  attr_accessible :article_id
  
  belongs_to :article
  belongs_to :user
end
