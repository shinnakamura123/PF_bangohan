class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @comments_page = @recipe.comments.page(params[:page]).per(10)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.order(created_at: :desc).limit(3)
    @comment = current_user.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.save
    flash.now[:notice] = 'コメントを送信しました。'
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    #recipeのshowで削除した時はlimit(3)で表示
    @comments = @recipe.comments.order(created_at: :desc).limit(3)
    #indexで削除した時はper(10)で表示させる
    @comments_page = @recipe.comments.page(params[:page]).per(10)
    @comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    flash.now[:alert] = 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
