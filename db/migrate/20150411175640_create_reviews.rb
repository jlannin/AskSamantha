class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
			t.text :comments
			t.integer :stars
			t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
