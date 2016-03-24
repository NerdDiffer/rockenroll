class AddForeignKeyAndIndexToUsers < ActiveRecord::Migration
  def change
    add_foreign_key :users, :people
    add_index :users, :person_id
  end
end
