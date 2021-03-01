class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.float :calories
      t.float :proteins
      t.float :carbohydrates
      t.float :fat
      t.float :price
      t.float :sodium
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
