class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :quantity
      t.integer :unit_id
      t.integer :food_id

      t.timestamps null: false
    end
  end
end
