class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  paginates_per 10
  validates :title, presence: true, length:{ minimum: 5 }
end
