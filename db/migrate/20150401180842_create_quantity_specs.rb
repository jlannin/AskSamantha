class CreateQuantitySpecs < ActiveRecord::Migration
  def change
    create_table :quantity_specs do |t|
      t.string :unit
      t.float :one
      t.timestamps null: false
    end
  end
end
