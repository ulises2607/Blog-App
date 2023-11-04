class User < ActiveRecord::Base
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments
  has_many :likes

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end
end
