class Post < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "author_id"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :update_post_counter # Cambiado a after_create

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    Rails.logger.debug("Ejecutando update_post_counter en Post #{user.id}, user.posts.count: #{user.posts.count}")
    user.update(post_counter: user.posts.count)
  end
  
end
