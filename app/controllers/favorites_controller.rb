class FavoritesController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = current_user.favorites.new(recipe_id: @recipe.id)
    @favorite.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by(recipe_id: @recipe.id)
    favorite.destroy
  end

  def favorites
    @user = User.find(params[:id])
    #自分の非公開レシピを見られるように
    if @user == current_user
      @favorites = @user.favorite_recipes.page(params[:page]).per(6).search(params[:search], params[:tag_id])
    else
      @favorites = @user.favorite_recipes.page(params[:page]).per(6).where(status: false).search(params[:search], params[:tag_id])
    end
  end
end
