class Article < ApplicationRecord
  paginates_per 10
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length:{ minimum: 5 }
end
