class ListsController < ApplicationController

  def index
    @lists = List.page(params[:page]).per(6).where(user_id: current_user.id).search(params[:search], params[:tag_id], params[:food_id])
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @list = List.new(user_id: current_user.id)
    @list.recipe_id = @recipe.id
    @list.save
    redirect_to request.referer, notice: 'Successful registration of my list!'
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    list = @recipe.lists.find_by(user_id: current_user.id)
    list.destroy
    redirect_to request.referer, notice: 'Successful removal from my list!'
  end

end
