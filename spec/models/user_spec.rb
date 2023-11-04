require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should create an user' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    expect(user).to be_valid
  end

  describe '#last_three_posts' do
    it 'returns the last three posts' do
      user = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')

      post1 = Post.create(user:, title: 'Post 1', text: 'Content 1', created_at: 1.day.ago)
      post2 = Post.create(user:, title: 'Post 2', text: 'Content 2', created_at: 2.days.ago)
      post3 = Post.create(user:, title: 'Post 3', text: 'Content 3', created_at: 3.days.ago)
      Post.create(user:, title: 'Post 4', text: 'Content 4', created_at: 4.days.ago)

      last_posts = user.last_three_posts

      expect(last_posts).to eq([post1, post2, post3])
      expect(last_posts.length).to eq(3)
    end

    it 'returns fewer than three posts if there are less than three' do
      user = User.create(name: 'Bob', photo: 'https://unsplash.com/photos/BobPhoto', bio: 'Bio for Bob')

      post1 = Post.create(user:, title: 'Post 1', text: 'Content 1', created_at: 1.day.ago)
      post2 = Post.create(user:, title: 'Post 2', text: 'Content 2', created_at: 2.days.ago)

      last_posts = user.last_three_posts

      expect(last_posts).to eq([post1, post2])
      expect(last_posts.length).to eq(2)
    end

    it 'returns an empty array if the user has no posts' do
      user = User.create(name: 'Charlie', photo: 'https://unsplash.com/photos/CharliePhoto', bio: 'Bio for Charlie')

      last_posts = user.last_three_posts

      expect(last_posts).to be_empty
    end
  end
end
