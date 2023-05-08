class UserBooksController < ApplicationController
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
    @user_book = UserBook.find(params[:id])
    @user_book.destroy
    redirect_to user_books_path
  end

  def edit
    @book_chapter = @user_book.book_chapters.find(params[:id])
  end

  def update
    @user_book = UserBook.find(params[:id])
    if @user_book.update(book_params)
      redirect_to user_book_path(@user_book)
    else
      render :edit
    end
  end

  def show
    @user_book = UserBook.find(params[:id])
  end

  def my_books
    @user_books = current_user.user_books
  end

  private

  def book_params
    params.require(:user_book).permit(:title, :book_cover, :author, :summary)
  end
end
