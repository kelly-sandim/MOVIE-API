class SessionsController < ApplicationController
	#Tmdb::Api.key( ENV['TMDB_API_KEY'] )
	def create
		@region = params[:id].nil? ? 'us' : params[:region]
		@popular = Tmdb::Movie.popular({region: 'us'})
		#@popular = Tmdb::Movie.popular
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			#sign_in(@user)
			sign_in
			redirect_to current_user
		else
			render action: :new
		end
	end
	def destroy
		sign_out
		redirect_to root_url
	end
	def pagination
		page = params[:page].nil? ? 1 : params[:page]
		region = params[:id].nil? ? 'us' : params[:region]
		popular = Tmdb::Movie.popular({page: page, region: region}).results
		#popular = Tmdb::Movie.popular.results
		render partial: 'movie', collection: popular, locals: {movie: popular}
	end

	# GET /search/:query
	def search
		if params[:query].blank?
			redirect_to(root_path, alert: "Campo de pesquisa vazio!") and return
		else
			@search = Tmdb::Search.movie(params[:query])
		end
	end
	def show
		@movie = Tmdb::Movie.detail(params[:id])
		@images = Tmdb::Movie.posters(params[:id])
	end
end