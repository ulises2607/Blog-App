require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'updates post likes_counter after save' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.create(title: 'Test Post', text: 'This is a test post', user:)
    Like.create(post:, user:)

    post.reload

    expect(post.likes_counter).to eq(1)
  end

  it 'belongs to a user' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    like = Like.create(user:)

    expect(like.user).to eq(user)
  end

  it 'belongs to a post' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.create(title: 'Test Post', text: 'This is a test post', user:)
    like = Like.create(post:)

    expect(like.post).to eq(post)
  end
end
