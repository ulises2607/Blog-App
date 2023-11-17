require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a succesful response' do
      User.create(name: 'Tomas', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      User.create(name: 'Alicia', photo: 'https://unsplash.com/photos/AlicePhoto', bio: 'Bio for Alice')
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'returns a succesful response' do
      user = User.create(name: 'Tomas', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end

    it 'assigns @user' do
      user = User.create(name: 'Tomas', photo: 'https://randomuser.me/api/portraits/thumb/men/75.jpg',
                         bio: 'Teacher from Mexico.')
      get user_path(user.id)
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      user = User.create(name: 'Tomas', photo: 'https://randomuser.me/api/portraits/med/men/75.jpg',
                         bio: 'Teacher from Mexico.')
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(name: 'Tomas', photo: 'https://randomuser.me/api/portraits/med/men/75.jpg',
                         bio: 'Teacher from Mexico.')
      get user_path(user.id)
      expect(response.body).to include('Teacher from Mexico.')
    end
  end
end
