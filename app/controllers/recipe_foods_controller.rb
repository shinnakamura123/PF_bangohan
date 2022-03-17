class RecipeFoodsController < ApplicationController

  def index
    @foods = Food.where(recipe_id: recipe.id)
  end


end
