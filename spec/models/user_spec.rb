require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#last_three_posts' do
    let(:user) { create(:user) }

    it 'returns the last three posts' do
      # Crear varios posts para el usuario en diferentes momentos
      post1 = create(:post, user: user, created_at: 1.day.ago)
      post2 = create(:post, user: user, created_at: 2.days.ago)
      post3 = create(:post, user: user, created_at: 3.days.ago)
      post4 = create(:post, user: user, created_at: 4.days.ago)

      # Llamar al método last_three_posts y verificar el orden y la cantidad
      last_posts = user.last_three_posts
      expect(last_posts).to eq([post1, post2, post3])
      expect(last_posts.length).to eq(3)
    end

    it 'returns fewer than three posts if there are less than three' do
      # Crear solo dos posts para el usuario
      post1 = create(:post, user: user, created_at: 1.day.ago)
      post2 = create(:post, user: user, created_at: 2.days.ago)

      # Llamar al método last_three_posts y verificar el número de posts
      last_posts = user.last_three_posts
      expect(last_posts).to eq([post1, post2])
      expect(last_posts.length).to eq(2)
    end

    it 'returns an empty array if the user has no posts' do
      # Llamar al método last_three_posts cuando el usuario no tiene posts
      last_posts = user.last_three_posts
      expect(last_posts).to be_empty
    end
  end
end
