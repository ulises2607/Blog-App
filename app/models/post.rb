class Post < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { maximum: 5000 }

  after_create :update_post_counter

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    user.update(post_counter: user.posts.count)
  end
end
