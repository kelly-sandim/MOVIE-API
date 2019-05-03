module MoviesHelper
	# return names of the genre based on genre_id
	#Tmdb::Api.key( ENV['TMDB_API_KEY'] )
	def get_genre(genre_ids)
		return if genre_ids.empty? 
		genres = []

		genre_ids.each do |genre_id|
			# genres = Tmdb::Genre.movie_list.select{ |m| m.id == genre_id }.first[:name]
			genre_value = Tmdb::Resource.new("/genre/#{genre_id}").get
			genres << genre_value['name']
		end

		genres.join(', ').to_s
	end
end
