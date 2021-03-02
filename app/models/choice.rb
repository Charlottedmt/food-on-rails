class Choice < ApplicationRecord
  enum rating: [ :dislike, :new, :like ]
  belongs_to :user
  belongs_to :meal
  validates :rating, presence: true
end
