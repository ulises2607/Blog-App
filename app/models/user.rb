class User < ActiveRecord::Base
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments
  has_many :likes

  validates :name, presence: true, uniqueness: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0 }

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end
end
