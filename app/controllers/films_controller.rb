class FilmsController < ApplicationController

  def index
    @films = Film.all
    @films = Film.order(:title)
    @films = Film.order(:title).paginate(page: params[:page], per_page: 12)
  end

  def show
    @film = Film.find(params[:id])
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.create(film_params)
    redirect_to film_path(@film)
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    @film.update(film_params)
    redirect_to film_path(@film)
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    respond_to do |format|
      format.html { redirect_to films_path }
      format.js   # aggiunge questa linea
    end
  end

  private

  def film_params
    params.require(:film).permit(:title, :year, :category, :score, :status, :trailer, :description, :actors, :director, :image)
  end
end
