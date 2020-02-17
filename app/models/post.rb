class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 2000}
  validates :user_id, presence: true
  
  belongs_to :user
  has_many :comments,dependent: :destroy
  has_many :likes,dependent: :destroy
  
  
  
  def self.search(keyword)
    if keyword
      Post.where(['title LIKE ? OR content LIKE ? ', "%#{keyword}%", "%#{keyword}%"])
    else
      Post.all
    end
  end
  
  
    
end
