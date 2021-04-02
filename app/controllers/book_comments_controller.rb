class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_to book_path(@book.id)
    else
      redirect_to book_path(@book.id)
    end
  end

  def destroy
    @book_comment = BookComment.find_by(book_id: params[:book_id], user_id: current_user.id)
    @book_comment.destroy
    redirect_to book_path(@book_comment.book)
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
