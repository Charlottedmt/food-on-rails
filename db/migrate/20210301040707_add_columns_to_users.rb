class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :status, :integer
  end
end
