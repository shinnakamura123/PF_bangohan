class CommentsController < ApplicationController

  def index
    @comments = Comment.page(params[:page]).per(10)
    @recipe = Recipe.find(params[:recipe_id])
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
    @comments = @recipe.comments.order(created_at: :desc).limit(2)
    @comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
