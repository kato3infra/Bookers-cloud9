class BooksController < ApplicationController
  #不要な部分
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:create] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:create] = "Failed to create the book. Please correct the errors below and try again."
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:update] = "Book was successfully updated."
      redirect_to book_path(book.id)
    else
      flash[:update] = "Failed to update the book. Please correct the errors below and try again."
      redirect_to edit_book_path(book.id)
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:destroy] = "Book was successfully deleted."
      redirect_to '/books'
    else
      flash[:destroy] = "Faild to delete the book."
      redirect_to '/books'
    end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
