class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :fridge_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
