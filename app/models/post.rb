class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2000}
  validates :user_id, presence: true
end
