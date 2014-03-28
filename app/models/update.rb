class Update < ActiveRecord::Base
  attr_accessible :article_id, :content, :user_id
  
  belongs_to :article, :touch => true
  belongs_to :user

  validates :content, :presence => true
  
  def username
    user.username + " -- " + user.created_at.to_s
  end
end
