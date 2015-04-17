class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :unit
      t.float :conversion_factor
      t.timestamps null: false
    end
  end
end
