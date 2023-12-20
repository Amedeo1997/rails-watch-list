# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.delete_all
Film.delete_all

User.create!(
  email: "Amedeo@example.com",
  password: "password"
)

Film.create!(
  title: "The Shawshank Redemption",
  year: 1994,
  category: "Drama",
  score: 9,
  status: "watched",
  trailer: "https://www.youtube.com/watch?v=6hB3S9bIaco",
  director: "Frank Darabont",
)
