class CreateUtilities < ActiveRecord::Migration
  def change
    create_table :utilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
