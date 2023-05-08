class BookChaptersController < ApplicationController
  before_action :set_user_book
  before_action :set_book_chapter, only: %i[show edit update destroy]

  def index
    @book_chapters = @user_book.book_chapters.order(:chapter_number)
  end

  def show; end

  def new
    @user_book = UserBook.find(params[:user_book_id])
    @book_chapter = @user_book.book_chapters.build
  end

  def edit
    @user_book = UserBook.find(params[:user_book_id])
    @book_chapter = @user_book.book_chapters.find(params[:id])
  end

  def create
    @book_chapter = @user_book.book_chapters.build(book_chapter_params)

    if @book_chapter.save
      redirect_to [@user_book, @book_chapter], notice: 'Chapter was successfully created.'
    else
      render :new
    end
  end

  def update
    if @book_chapter.update(book_chapter_params)
      redirect_to [@user_book, @book_chapter], notice: 'Chapter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book_chapter.destroy
    redirect_to user_book_book_chapters_path(@user_book), notice: 'Chapter was successfully destroyed.'
  end

  private

  def set_user_book
    @user_book = UserBook.find(params[:user_book_id])
  end

  def set_book_chapter
    @book_chapter = @user_book.book_chapters.find(params[:id])
  end

  def book_chapter_params
    params.require(:book_chapter).permit(:title, :chapter_number, :content)
  end
end
