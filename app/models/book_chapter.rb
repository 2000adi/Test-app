class BookChapter < ApplicationRecord
  belongs_to :user_book
  has_one_attached :audio
end
