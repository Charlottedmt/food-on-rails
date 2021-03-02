class ChangeStatusNameToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :status, :integer
    add_column :users, :goal, :integer
    remove_column :choices, :status, :integer
    add_column :users, :rating, :integer
  end
end
