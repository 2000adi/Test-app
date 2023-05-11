class UserBooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user_book, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def download_pdf
    @user_book = UserBook.find(params[:id])

    respond_to do |format|
      format.pdf do
        render pdf: 'book_chapters',                    # Specify the PDF filename
               template: 'user_books/book_chapters_pdf', # Path to the PDF template
               layout: 'pdf.html.erb',                   # Layout file for PDF rendering
               page_size: 'A4'                           # Optional: Page size (e.g., 'A4', 'Letter')
      end
    end
  end

  def index
    @user_books = if params[:search].present?
                    UserBook.where('author LIKE :search OR title LIKE :search', search: "%#{params[:search]}%")
                  else
                    UserBook.all
                  end.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user_book = UserBook.new
  end

  def create
    @user_book = UserBook.new(book_params)
    @user_book.user_id = current_user.id
    @user_book.author = current_user.username
    if @user_book.save
      redirect_to user_book_path(@user_book)
    else
      render :new
    end
  end

  def destroy
    @user_book.destroy
    redirect_to user_books_path
  end

  def edit; end

  def update
    if @user_book.update(book_params)
      redirect_to user_book_path(@user_book)
    else
      render :edit
    end
  end

  def show
    @user_book = UserBook.find(params[:id])
    @book_chapters = @user_book.book_chapters.paginate(page: params[:page], per_page: 10)
  end

  def my_books
    @user_books = current_user.user_books.paginate(page: params[:page], per_page: 10)
  end

  private

  def book_params
    params.require(:user_book).permit(:title, :book_cover, :author, :summary)
  end

  def set_user_book
    @user_book = UserBook.find(params[:id])
  end

  def authorize_user!
    unless current_user.admin? || current_user.username == @user_book.author
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to @user_book
    end
  end
end
