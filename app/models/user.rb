class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :post_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts(limit = 3)
    authored_posts.order(created_at: :desc).limit(limit)
  end
end
