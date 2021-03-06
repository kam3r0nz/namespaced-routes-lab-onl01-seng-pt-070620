class ArtistsController < ApplicationController
  def index
    @preference = Preference.first

    if @preference
      if @preference.artist_sort_order = "ASC"
        @artists = Artist.all.sort_by{|artist| artist.name}
      else
        @artists = Artist.all.sort_by{|artist| artist.name}.reverse
      end
    end
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    if Preference.first.allow_create_artists == true
      @artist = Artist.new
    else
      redirect_to artists_path
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
