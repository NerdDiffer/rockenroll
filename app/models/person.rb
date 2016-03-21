class Person < ActiveRecord::Base
  has_one  :account, class_name: 'User', inverse_of: :person
  has_many :students, through: :enrollments, source: 'teacher'
  has_many :teachers, through: :enrollments, source: 'student'
end
