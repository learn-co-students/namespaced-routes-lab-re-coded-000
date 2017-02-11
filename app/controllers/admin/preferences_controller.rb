class Admin::PreferencesController < ApplicationController
	def index
		@preference = Preference.first_or_create(allow_create_artists: true, allow_create_songs: true, song_sort_order: "DESC", artist_sort_order: "DESC")
	end

	def update
    	@preference = Preference.find(params[:id])
    	@preference.update(preference_params)
    	redirect_to :index
  	end

  	def first_or_create(attr_hash)
  		pre = Preference.first
     !pre ? Preference.create(attr_hash) : pre
  	end
  	
	private
	def preference_params
		  params.require(:preference).permit(:allow_create_songs, :allow_create_artists, :song_sort_order, :artist_sort_order)
	end
end