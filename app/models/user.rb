class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :email, presence: true, uniqueness: true

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def fist_three_posts
    posts.order(created_at: :asc).limit(3)
  end
end
