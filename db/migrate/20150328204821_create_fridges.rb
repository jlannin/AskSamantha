class CreateFridges < ActiveRecord::Migration
  def change
    create_table :fridges do |t|

      t.timestamps null: false
    end
  end
end
