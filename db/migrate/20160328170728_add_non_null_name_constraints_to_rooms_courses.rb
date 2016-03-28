class AddNonNullNameConstraintsToRoomsCourses < ActiveRecord::Migration
  def up
    # Add NOT NULL constraint to these columns
    change_column_null :courses, :name,  false
    change_column_null :rooms, :name, false
  end

  def down
    # Drop NOT NULL constraint for these columns
    change_column_null :rooms, :name,  true
    change_column_null :courses, :name, true
  end
end
