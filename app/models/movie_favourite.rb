class MovieFavourite < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
