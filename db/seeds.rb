# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create(name: "Tom", photo: "https://randomuser.me/api/portraits/men/1.jpg", bio: "Brasilian student")
User.create(name: "Silvia", photo: "https://randomuser.me/api/portraits/women/72.jpg", bio: "Italian student")


(1..25).each do |n|
    Post.create(
      title: "Post #{n}",
      text: "This is my post number #{n}",
        author_id: 1
    )
  end
  
  # Crear posts para el usuario 2
  (1..8).each do |n|
    Post.create(
      title: "Post #{n}",
      text: "This is my post number #{n}",
        author_id: 2
    )
  end

