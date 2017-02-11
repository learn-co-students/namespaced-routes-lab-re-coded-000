class ArtistsController < ApplicationController
  def index
    pref = Preference.first_or_create(artist_sort_order: "DESC")
    pref.artist_sort_order = "DESC" if pref.artist_sort_order.blank?
    @artists = Artist.all.order(name: pref.artist_sort_order)
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    pref = Preference.first
    if pref && !pref.allow_create_artists
      redirect_to artists_path
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end