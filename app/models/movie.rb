class Movie < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :reviews
  has_many :movie_relationships
  has_many :fans, through: :movie_relationships, source: :user
end
