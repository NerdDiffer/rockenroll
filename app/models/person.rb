class Person < ActiveRecord::Base
  has_one :account, class_name: 'User', inverse_of: :person

  has_many :enrollments_as_teacher,
    foreign_key: 'teacher_id',
    class_name: 'Enrollment',
    inverse_of: :teacher
  has_many :students, through: :enrollments_as_teacher

  has_many :enrollments_as_student,
    foreign_key: 'student_id',
    class_name: 'Enrollment',
    inverse_of: :student
  has_many :teachers, through: :enrollments_as_student
end
