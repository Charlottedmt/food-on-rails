class Choice < ApplicationRecord
  enum status: [ :dislike, :new, :like ]
  belongs_to :user
  belongs_to :meal
  validates :status, presence: true
end
