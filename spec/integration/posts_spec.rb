require 'rswag/specs'

describe 'Posts API', type: :request do
    # Index Test
    path '/users/{user_id}/posts' do
  
      get 'Retrieves all posts for a user' do
        tags 'Posts'
        produces 'application/json'
        parameter name: :user_id, in: :path, type: :integer
  
        response '200', 'posts found' do
          let(:user_id) { create(:user).id }
          run_test!
        end
      end
    end
  
    # Show Test
    path '/users/{user_id}/posts/{id}' do
  
      get 'Retrieves a specific post' do
        tags 'Posts'
        produces 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :id, in: :path, type: :integer
  
        response '200', 'post found' do
          let(:user_id) { create(:user).id }
          let(:id) { create(:post, user_id: user_id).id }
          run_test!
        end
      end
    end
  
    # Create Test
    path '/users/{user_id}/posts' do
  
      post 'Creates a post' do
        tags 'Posts'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            content: { type: :string }
          },
          required: ['title', 'content']
        }
  
        response '201', 'post created' do
          let(:user_id) { create(:user).id }
          let(:post) { { title: 'New Post', content: 'Post content' } }
          run_test!
        end
  
        response '422', 'invalid request' do
          let(:user_id) { create(:user).id }
          let(:post) { { title: '' } } # Invalid data
          run_test!
        end
      end
    end
  
    # Destroy Test
    path '/users/{user_id}/posts/{id}' do
  
      delete 'Deletes a post' do
        tags 'Posts'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :id, in: :path, type: :integer
  
        response '204', 'post deleted' do
          let(:user_id) { create(:user).id }
          let(:id) { create(:post, user_id: user_id).id }
          run_test!
        end
  
        response '401', 'unauthorized' do
          let(:user_id) { create(:user).id }
          let(:id) { create(:post, user_id: user_id).id }
          # Here you might simulate an unauthorized user trying to delete the post
          run_test!
        end
      end
    end
  end
  