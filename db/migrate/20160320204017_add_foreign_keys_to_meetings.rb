class AddForeignKeysToMeetings < ActiveRecord::Migration
  def change
    add_foreign_key :meetings, :courses
    add_foreign_key :meetings, :rooms
  end
end
