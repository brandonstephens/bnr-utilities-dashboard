class RemoveUserIdFromUtilities < ActiveRecord::Migration
  def change
    remove_index :utilities, column: :user_id
    remove_column :utilities, :user_id, :integer
  end
end
