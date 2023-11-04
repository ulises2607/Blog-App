require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'updates post comments_counter after save' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.create(title: 'Test Post', text: 'This is a test post', user:)
    Comment.create(post:, user:, text: 'Hi Tom!')

    post.reload

    expect(post.comments_counter).to eq(1)
  end

  it 'belongs to a user' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    comment = Comment.create(user:, text: 'Comment text')

    expect(comment.user).to eq(user)
  end

  it 'belongs to a post' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.create(title: 'Test Post', text: 'This is a test post', user:)
    comment = Comment.create(post:, text: 'Comment text')

    expect(comment.post).to eq(post)
  end
end
