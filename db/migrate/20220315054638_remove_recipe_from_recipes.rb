class RemoveRecipeFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :recipe, :text
  end
end
