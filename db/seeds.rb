# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times do 
#  User.create(
#    firstname: Faker::Name.first_name, 
#    lastname: Faker::Name.last_name, 
#    email: Faker::Internet.email, 
#    password: Faker::Internet.password
#  )
# end

# imdb_movies = OMDB.search('rotten') + OMDB.search('mangoes')
# imdb_movies.each do |movie|
#   if movie.year
#     Movie.create(
#       title: movie.title,
#       director: "nil",
#       runtime_in_minutes: movie.runtime,
#       description: "nil",
#       release_date: "#{movie.year}-01-01"
#       # image: 
#     )
#   end
# end

@movies = Imdb::Top250.new.movies
# @movies = @movies.movies

@movies.each do |movie|
  Movie.create(
    title: movie.title.split(".\n ")[1],
    director: movie.director[0],
    runtime_in_minutes: movie.length,
    description: movie.plot_summary,
    release_date: DateTime.parse(movie.release_date),
    remote_image_url: movie.poster 
  )
end