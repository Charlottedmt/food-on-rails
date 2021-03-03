class Choice < ApplicationRecord
  enum rating: [ :dislike, :unrated, :like ]
  belongs_to :user
  belongs_to :meal
  validates :rating, presence: true
end
