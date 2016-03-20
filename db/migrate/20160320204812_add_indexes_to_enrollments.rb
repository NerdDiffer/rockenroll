class AddIndexesToEnrollments < ActiveRecord::Migration
  def change
    add_index :enrollments, :course_id
    add_index :enrollments, :teacher_id
    add_index :enrollments, :student_id
  end
end
