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
                "Nights in Rodanthe", "The Notebook", "Marley & Me", "Sweet November"]

trailers = {
  "Nimona" => "https://www.netflix.com/watch/81444554?trackId=255824129&tctx=0%2C0%2Cdbadbee8-3d7f-49b9-bc90-28ada9484624-907591218%2Cdbadbee8-3d7f-49b9-bc90-28ada9484624-907591218%7C2%2Cunknown%2C%2C%2C%2C%2CVideo%3A81444554%2CminiDpPlayButton",
  "All the Light We Cannot See" => "https://streamingcommunity.cz/watch/6822",
  "500 Days of Summer" => "https://streamingcommunity.cz/watch/708",
  "Brother Bear" => "https://altadefinizione.bet/animazione/2021-koda-fratello-orso.html",
  "Atlantis: The Lost Empire" => "https://altadefinizione.bet/animazione/2157-atlantis-limpero-perduto-streaming.html",
  "Moana" => "https://streamingcommunity.cz/watch/1831",
  "The Boy, the Mole, the Fox and the Horse" => "https://altadefinizione.bet/animazione/20758-il-bambino-la-talpa-la-volpe-e-il-cavallo-streaming.html",
  "Seeking a Friend for the End of the World" => "https://altadefinizione.bet/commedia/4163-cercasi-amore-per-la-fine-del-mondo-streaming.html",
  "Ice Age" => "https://streamingcommunity.cz/watch/823",
  "Nights in Rodanthe" => "https://altadefinizione.bet/drammatico/2660-come-un-uragano.html",
  "The Notebook" => "https://altadefinizione.bet/drammatico/5913-le-pagine-della-nostra-vita.html",
  "Marley & Me" => "https://altadefinizione.bet/commedia/7538-io-e-marley.html",
  "Sweet November" => "https://altadefinizione.bet/drammatico/13276-sweet-november-dolce-novembre-streaming.html"
}

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
      trailer: trailers[title]
      # Aggiungi qui altri campi necessari
    )
    puts "Film aggiunto: #{film_data["Title"]}"
  else
    puts "Errore nel recuperare il film: #{title}"
  end
end
