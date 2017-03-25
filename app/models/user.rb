class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews
  has_many :movie_relationships
  has_many :favorited_movies, :through => :movie_relationships, :source => :movie

  def is_fan_of?(movie)
    favorited_movies.include?(movie)
  end
end
