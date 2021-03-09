class AddRatingToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :rating, :integer, :default => 1
  end
end
