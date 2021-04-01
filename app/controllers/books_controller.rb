class BooksController < ApplicationController
    before_action :ensure_correct_user, only: [:update,:edit]


  def show
     @book = Book.find(params[:id])
     @new_book = Book.new
  end

  def index
    @book = Book.new
    @books = Book.all
    @favorite_count =  Favorite.where(book_id: params[:book_id], user_id: current_user.id).count
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      flash[:notice] = @book.errors.full_messages
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
  
  def book_params
       params.require(:book).permit(:title, :body)    
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
