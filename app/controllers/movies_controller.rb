class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end

  def rent
    user = User.find(params[:user_id])
    movie = Movie.find(params[:id])
    @rental = RentingService.new(user).new_rental(movie)
    render json: @rental
  rescue DomainException => e
    render json: {
      error: e.to_s
    }, status: :bad_request
  end
end