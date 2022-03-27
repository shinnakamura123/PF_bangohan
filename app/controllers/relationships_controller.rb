class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    flash.now[:notice] = 'フォローしました。'
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    flash.now[:alert] = 'フォロー解除しました。'
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
