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

require 'httparty'
require 'cgi'

film_titles = ["Nimona", "All the Light We Cannot See", "500 Days of Summer", "Brother Bear", "Atlantis: The Lost Empire",
                "Moana", "The Boy, the Mole, the Fox and the Horse", "Seeking a Friend for the End of the World", "Ice Age",
                "Nights in Rodanthe"]

film_titles.each do |title|
  response = HTTParty.get("http://www.omdbapi.com/?t=#{CGI.escape(title)}&apikey=#{ENV['OMDB_API_KEY']}")

  if response.success?
    film_data = response.parsed_response

    Film.create!(
      title: film_data["Title"],
      year: film_data["Year"],
      category: film_data["Genre"],
      director: film_data["Director"],
      score: film_data["imdbRating"],
      description: film_data["Plot"],
      actors: film_data["Actors"],
      poster: film_data["Poster"],
      trailer: film_data["Trailer"]
      # Aggiungi qui altri campi necessari
    )
    puts "Film aggiunto: #{film_data["Title"]}"
  else
    puts "Errore nel recuperare il film: #{title}"
  end
end
