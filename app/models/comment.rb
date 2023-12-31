class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  after_save :update_comment_count

  def update_comment_count
    post.update(comments_counter: post.comments.count)
  end
end
