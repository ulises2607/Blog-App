require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title, text, and user association' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.new(title: 'Test Post', text: 'This is a test post', user:)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = Post.new(text: 'This is a test post')
    expect(post).to_not be_valid
  end

  it 'is not valid without text' do
    post = Post.new(title: 'Test Post')
    expect(post).to_not be_valid
  end

  it 'is not valid if title is too long' do
    post = Post.new(title: 'A' * 251, text: 'This is a test post')
    expect(post).to_not be_valid
  end

  it 'is not valid if text is too long' do
    post = Post.new(title: 'Test Post', text: 'A' * 5001)
    expect(post).to_not be_valid
  end

  it 'is valid with valid attributes' do
    user = User.create(name: 'User Name', photo: 'user.jpg', bio: 'Bio text')
    post = Post.new(
      user:,
      title: 'Test Title',
      text: 'Test Text',
      comments_counter: 0, # You can set this to any non-negative value
      likes_counter: 0 # You can set this to any non-negative value
    )
    expect(post).to be_valid
  end

  it 'is not valid with a negative comments counter' do
    user = User.create(name: 'User Name', photo: 'user.jpg', bio: 'Bio text')
    post = Post.new(
      user:,
      title: 'Test Title',
      text: 'Test Text',
      comments_counter: -1,
      likes_counter: 0
    )
    expect(post).not_to be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is not valid with a negative likes counter' do
    user = User.create(name: 'User Name', photo: 'user.jpg', bio: 'Bio text')
    post = Post.new(
      user:,
      title: 'Test Title',
      text: 'Test Text',
      comments_counter: 0,
      likes_counter: -1
    )
    expect(post).not_to be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'has five recent comments' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    post = Post.create(title: 'Test Post', text: 'This is a test post', user:)
    Comment.create(post:, user:, text: 'Comment 1')
    comment2 = Comment.create(post:, user:, text: 'Comment 2')
    comment3 = Comment.create(post:, user:, text: 'Comment 3')
    comment4 = Comment.create(post:, user:, text: 'Comment 4')
    comment5 = Comment.create(post:, user:, text: 'Comment 5')
    comment6 = Comment.create(post:, user:, text: 'Comment 6')

    recent_comments = post.five_recent_comments

    expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    expect(recent_comments.length).to eq(5)
  end

  it 'updates user post_counter after create' do
    user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
    Post.create(title: 'Test Post', text: 'This is a test post', user:)

    user.reload

    expect(user.post_counter).to eq(1)
  end
end
