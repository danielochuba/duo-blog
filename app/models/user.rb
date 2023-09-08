class User < ApplicationRecord
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def recent_posts(limit = 3)
    authored_posts.order(created_at: :desc).limit(limit)
  end
end
