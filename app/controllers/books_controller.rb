class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show create_booking]
  before_action :check_admin_role, only: %i[new create edit update destroy]
  before_action :set_book, only: %i[show edit update destroy book]

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  def create_booking
    @book = Book.find(params[:id])
    @booking = current_user.bookings.build(book_id: @book.id)

    if @booking.save
      redirect_to @booking
    else
      flash.now[:alert] = if @booking.errors[:user_id].include?('has already booked this book')
                            'Booking failed: you have already booked this book'
                          else
                            'Booking failed'
                          end
      render 'books/show'
    end
  end

  private

  def check_admin_role
    redirect_to books_path, alert: 'You do not have permission to perform this action' unless current_user&.admin?
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :quantity, :book_cover)
  end
end
