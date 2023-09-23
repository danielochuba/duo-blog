class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  enum role: %i[user admin author]

  validates :name, presence: true
  validates :post_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def admin?
    role == '1' # self.role == 'admin'
  end

  def author?
    role == '2' # self.role == 'author'
  end

  def user?
    role == '0' # self.role == 'user'
  end

  def recent_posts(limit = 3)
    authored_posts.order(created_at: :desc).limit(limit)
  end
end
