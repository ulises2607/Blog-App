require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    # No es necesario crear usuarios y posts aquí, ya que ya están en la base de datos de prueba
    @user = User.find_by(name: 'Tom')
  end

  scenario 'I can see the user\'s profile picture' do
    visit user_path(@user)

    # Verificar que se muestra la imagen de perfil del usuario
    expect(page).to have_css('.img-user-container img')
  end

  scenario 'I can see the user\'s username' do
    visit user_path(@user)

    # Verificar que se muestra el nombre de usuario del usuario
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)

    # Verificar que se muestra el número de posts del usuario
    expect(page).to have_content("Number of posts: 25") # Ajusta el número según tus datos específicos
  end

  scenario 'I can see the user\'s bio' do
    visit user_path(@user)

    # Verificar que se muestra la biografía del usuario
    expect(page).to have_css('.bio-container p', text: 'Brasilian student')
  end

  scenario 'I can see the user\'s first 3 posts' do
    visit user_path(@user)

    # Verificar que se muestran los primeros 3 posts del usuario
    @user.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'I can see a button that lets me view all of a user\'s posts' do
    visit user_path(@user)

    # Verificar que se muestra un botón para ver todos los posts del usuario
    expect(page).to have_button('See all posts')
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user)
  
    #Click on the first user post
    first('.post-item a').click

    # Verify that it redirects to the post's show page correctly
    expect(page.current_path).to include("/users/1/posts/1")

  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user)
  
    # Hacer clic en el botón para ver todos los posts del usuario
    click_link 'See all posts'
  
    # Verificar que se redirige a la página de índice de posts del usuario correctamente
    expect(page).to have_current_path("/users/1/posts")

  end
end
