class UserBook < ApplicationRecord
  belongs_to :user
  has_many :book_chapters, dependent: :destroy
  has_one_attached :book_cover
end
