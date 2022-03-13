class ListsController < ApplicationController

  def index
    @lists = List.page(params[:page]).per(6).where(user_id: current_user.id)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @list = @recipe.lists.new(user_id: current_user.id)
    @list.save
    redirect_to request.referer
  end

  def destroy
    @list = List.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    @list.destroy
    redirect_to request.referer
  end

end
