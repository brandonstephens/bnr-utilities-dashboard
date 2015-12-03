class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.belongs_to :utility, index: true
      t.belongs_to :user, index: true
      t.integer :permission

      t.timestamps
    end
  end
end
