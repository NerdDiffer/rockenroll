class AddForeignKeysToEnrollments < ActiveRecord::Migration
  def change
    add_foreign_key :enrollments, :courses
    add_foreign_key :enrollments, :people, column: 'teacher_id'
    add_foreign_key :enrollments, :people, column: 'student_id'
  end
end
