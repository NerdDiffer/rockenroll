class Enrollment < ActiveRecord::Base
  belongs_to :course, inverse_of: :enrollments
  belongs_to :teacher, class_name: 'Person', foreign_key: 'teacher_id'
  belongs_to :student, class_name: 'Person', foreign_key: 'student_id'
end
