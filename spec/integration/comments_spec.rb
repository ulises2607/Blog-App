describe 'Comments API', type: :request do
    # Create Test
    path '/users/{user_id}/posts/{post_id}/comments' do
  
      post 'Creates a comment' do
        tags 'Comments'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :post_id, in: :path, type: :integer
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string }
          },
          required: ['text']
        }
  
        response '201', 'comment created' do
          let(:user_id) { create(:user).id }
          let(:post_id) { create(:post, user_id: user_id).id }
          let(:comment) { { text: 'A test comment.' } }
          run_test!
        end
      end
    end
  
    # Destroy Test
    path '/users/{user_id}/posts/{post_id}/comments/{id}' do
  
      delete 'Deletes a comment' do
        tags 'Comments'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :post_id, in: :path, type: :integer
        parameter name: :id, in: :path, type: :integer
  
        response '204', 'comment deleted' do
          let(:user_id) { create(:user).id }
          let(:post_id) { create(:post, user_id: user_id).id }
          let(:id) { create(:comment, post_id: post_id).id }
          run_test!
        end
  
        response '401', 'unauthorized' do
          let(:user_id) { create(:user).id }
          let(:post_id) { create(:post, user_id: user_id).id }
          let(:id) { create(:comment, post_id: post_id).id }
          # Here you might simulate an unauthorized user trying to delete the comment
          run_test!
        end
      end
    end
  end
  