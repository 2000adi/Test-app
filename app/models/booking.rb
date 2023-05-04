class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, uniqueness: { scope: :book_id, message: 'has already booked this book' }
  validate :member_book_limit, on: :create

  private

  def member_book_limit
    errors.add(:user_id, 'member book limit exceeded') if user.member? && user.bookings.count >= 5
  end
end
