class AddBackgroundToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :background, :text
  end
end
