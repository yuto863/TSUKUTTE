class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2000}
end
