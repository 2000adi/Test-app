class BookingsController < ApplicationController
  def my_bookings
    @bookings = current_user.bookings
  end
end
