class RecipesController < ApplicationController

  def index
    @recipes = Recipe.page(params[:page]).per(6).where(status: false).search(params[:search], params[:tag_id], params[:food_id])
    @tags = Tag.all
  end

  def new
    @recipe = Recipe.new
    @recipe.user_id = current_user.id
  end

  def create
    @user = current_user
    @food = Food.new
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      @list= @user.lists.new(recipe_id: @recipe.id)
      @list.save
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @comments = @recipe.comments.order(created_at: :desc).page(params[:page]).per(3).limit(3)
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
    params.require(:recipe).permit(
      :user_id, :recipe_name, :image, :man_count, :background, :point, :status, tag_ids: [],
      recipe_foods_attributes: [:id, :food_id, :quantity, :_destroy],
      steps_attributes: [:id, :method, :image, :_destroy]
      )
  end
end
