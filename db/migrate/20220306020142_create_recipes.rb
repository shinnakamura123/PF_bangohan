class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.string :recipe_name, null: false
      t.integer :man_count, null: false
      t.text :recipe, null: false
      t.text :point, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
