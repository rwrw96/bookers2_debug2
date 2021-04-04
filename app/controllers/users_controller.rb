class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]
  

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @follow = current_user.active_relationships.build(follower_id: params[:user_id])
    @follow.save
  end
  
  def edit
    @user = User.find(params[:id])
    @books = Book.all
  end

  def update
    @books = Book.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      flash[:notice] = @user.errors.full_messages
      render :edit
    end
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def followeds
    @user = User.find(params[:id])
    @users = @user.followeds
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def book_params
    params.require(:user).permit(:title, :body)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end
