class AddNonNullConstraintsToEnrollments < ActiveRecord::Migration
  def up
    # Add NOT NULL constraint to these columns
    change_column_null :enrollments, :course_id,  false
    change_column_null :enrollments, :student_id, false
    change_column_null :enrollments, :teacher_id, false
  end

  def down
    # Drop NOT NULL constraint for these columns
    change_column_null :enrollments, :course_id,  true
    change_column_null :enrollments, :student_id, true
    change_column_null :enrollments, :teacher_id, true
  end
end
