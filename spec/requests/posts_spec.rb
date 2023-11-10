require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns a succesful response' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_posts_path(user.id)
      expect(response).to have_http_status(200)
    end

    it 'assigns @posts' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_posts_path(user.id)
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET /show' do
    it 'returns a succesful response' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_post_path(user.id, post.id)
      expect(response).to have_http_status(200)
    end

    it 'assigns @post' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_post_path(user.id, post.id)
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the show template' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_post_path(user.id, post.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Post 1', text: 'Content 1')
      get user_post_path(user.id, post.id)
      puts response.body
      expect(response.body).to include('Content 1')
    end
  end
end
