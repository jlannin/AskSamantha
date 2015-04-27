class CreateGroceries < ActiveRecord::Migration
  def change
    create_table :groceries do |t|
      t.integer :user_id
      t.integer :quantity
      t.integer :unit_id
      t.integer :food_id
      t.timestamps null: false
    end
  end
end
