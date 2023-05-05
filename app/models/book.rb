class Book < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  validate :book_quantity_limit, on: :create
  has_one_attached :book_cover

  private

  def book_quantity_limit
    errors.add(:quantity, 'book quantity limit exceeded') if quantity <= bookings.count
  end
end
