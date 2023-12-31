class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  after_save :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end
end
