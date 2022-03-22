class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
		redirect_to request.referer, notice: 'Successfully followed!'
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer, notice: 'Successfully unfollowed!'
  end

  def followings #フォロー一覧
    @user = User.find(params[:user_id])
		@users = @user.followings.page(params[:page]).per(10)
  end

  def followers #フォロワー一覧
    @user = User.find(params[:user_id])
		@users = @user.followers.page(params[:page]).per(10)
  end
end
