class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.text :method
      t.integer "recipe_id", null: false

      t.timestamps
    end
  end
end
