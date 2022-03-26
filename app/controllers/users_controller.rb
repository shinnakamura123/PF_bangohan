class UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user =current_user
      render 'edit'
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '会員情報が更新されました。'
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: '退会しました。'
  end

  def recipes
    @user = User.find(params[:id])
    #自分の非公開レシピは見れるようにif分岐を記述
    if @user == current_user
      @recipes = @user.recipes.page(params[:page]).per(6).search(params[:search], params[:tag_id], params[:food_id])
    else
      @recipes = @user.recipes.page(params[:page]).per(6).where(status: false).search(params[:search] ,params[:tag_id], params[:food_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
