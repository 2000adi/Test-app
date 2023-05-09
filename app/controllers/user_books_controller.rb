class UserBooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user_book, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @user_books = UserBook.all
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

  def show; end

  def my_books
    @user_books = current_user.user_books
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
