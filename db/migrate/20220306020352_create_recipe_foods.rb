class CreateRecipeFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :recipe_id, null: false
      t.integer :food_id, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
