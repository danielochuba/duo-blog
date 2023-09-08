class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes



  # Method to return the 5 most recent comments for a given post
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  # Method to update the likes counter for a post


  after_save :update_user_posts_counter
  after_save :update_likes_counter

  private

  def update_user_posts_counter
    author.update(post_count: author.authored_posts.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end
end
