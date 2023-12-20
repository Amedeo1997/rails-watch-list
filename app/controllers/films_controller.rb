class FilmsController < ApplicationController

  def index
    @films = Film.all
    @films = Film.order(:title)
  end

  def show
    @film = Film.find(params[:id])
  end

  private

  def film_params
    params.require(:film).permit(:title, :year, :category, :score, :status, :trailer, :description, :actors, :director, :image)
  end
end
