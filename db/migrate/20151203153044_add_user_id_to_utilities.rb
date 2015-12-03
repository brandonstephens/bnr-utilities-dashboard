class AddUserIdToUtilities < ActiveRecord::Migration
  def change
    add_column :utilities, :user_id, :integer
    add_index :utilities, :user_id
  end
end
