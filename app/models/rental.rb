class Rental < ApplicationRecord
    validates :user_id, uniqueness: {scope: :movie_id, message: 'has already rented this movie'}
    belongs_to :user
    belongs_to :movie
end