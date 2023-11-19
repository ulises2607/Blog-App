describe 'Users API', type: :request do
    # Index Test
    path '/users' do
  
      get 'Retrieves all users' do
        tags 'Users'
        produces 'application/json'
  
        response '200', 'users listed' do
          run_test!
        end
      end
    end
  
    # Show Test
    path '/users/{id}' do
  
      get 'Retrieves a specific user' do
        tags 'Users'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer
  
        response '200', 'user found' do
          let(:id) { create(:user).id }
          run_test!
        end
  
        # Optional: If you want to test a scenario where the user is not found
        response '404', 'user not found' do
          let(:id) { 'invalid' } # Assuming 'invalid' is not a valid id
          run_test!
        end
      end
    end
  end
  