class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2000}
  validates :user_id, presence: true
  
  belongs_to :user
  has_many :comments,dependent: :destroy
  
  
  def self.search(title)
    if title
      Post.where(['title LIKE ?', "%#{title}%"])
    else
      Post.all
    end
  end
    
end
