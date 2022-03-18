class CommentsController < ApplicationController

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
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.order(created_at: :desc)
    @comments_page = @recipe.comments.page(params[:page]).per(10)
    @comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
