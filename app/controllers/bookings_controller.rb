class BookingsController < ApplicationController
  def my_bookings
    @bookings = current_user.bookings
  end

  def bookings_index
    @bookings = current_user.bookings

    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="bookings.xlsx"'
        response.headers['Content-Type'] = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        send_data generate_xlsx_data(@bookings), filename: 'bookings.xlsx', disposition: 'attachment'
      end
    end
  end

  private

  def generate_xlsx_data(bookings)
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: 'Bookings') do |sheet|
        sheet.add_row ['Book Title', 'Author', 'Booking Date']

        bookings.each do |booking|
          sheet.add_row [booking.book.title, booking.book.author, booking.created_at]
        end
      end
    end.to_stream.read
  end
end
