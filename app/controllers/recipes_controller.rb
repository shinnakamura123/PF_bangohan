class RecipesController < ApplicationController

  def index
    @recipes= Recipe.page(params[:page]).per(6).where(status: false)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      @user.lists.create(recipe_id: @recipe.id)
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id = current_user.id
      render 'edit'
    else
      redirect_to recipe_path(@recipe)
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :recipe_name, :image, :man_count, :recipe, :point, :status, recipe_foods_attributes: [:id, :food_id, :quantity, :_destroy])
  end
end
