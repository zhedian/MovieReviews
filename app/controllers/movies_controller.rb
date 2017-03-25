class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_movie_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
  end

  def edit

  end

  def update

    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy

    @movie.destroy
    redirect_to movies_path
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def like
    @movie = Moive.find(params[:id])
    if !current_user.is_fan_of?(@movie)
      current_user.like!(@group), notice: "成功喜欢上它了！"
    else
      warning: "你已经喜欢它了！"
    end
    redirect_to movie_path(@movie)
  end

  def do_not_like
    @movie = Movie.find(params[:id])
    if current_user.is_fan_of?(@movie)
      current_user.do_not_like!(@movie), alert: "你不喜欢它了！"
    else
      waring: "你本来就不喜欢它！"
    end
    redirect_to movie_path(@movie)
     
  end

  private

  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "You have no permission"
    end
  end

  def movie_params
    params.require(:movie).permit(:name, :description)
  end


end
