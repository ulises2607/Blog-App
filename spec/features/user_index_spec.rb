# spec/features/user_index_spec.rb

require 'rails_helper'

RSpec.feature 'User index page', type: :feature do

  scenario 'I can see the username of all other users' do
    visit users_path

    # Verificar que se muestren los nombres de usuario en la página de índice de usuarios
    expect(page).to have_content('Tom')
    expect(page).to have_content('Silvia')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    # Verificar que se muestren las imágenes de perfil en la página de índice de usuarios
    expect(page).to have_css('.img-user-container img', count: User.count)
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    # Verificar que se muestra el número de posts para cada usuario en la página de índice de usuarios
    expect(page).to have_content('Number of posts: 25') # Ajusta el número según tus datos específicos
    expect(page).to have_content('Number of posts: 8')  # Ajusta el número según tus datos específicos
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    # Hacer clic en el enlace del primer usuario
    click_link 'Tom'

    # Verificar que se redirige a la página del usuario correctamente
    expect(page).to have_current_path(user_path(User.find_by(name: 'Tom')))
  end
end
