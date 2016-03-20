class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :course_id
      t.integer :teacher_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
