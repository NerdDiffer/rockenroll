class Course < ActiveRecord::Base
  has_many :enrollments, inverse_of: :course
  has_many :meetings,    inverse_of: :course

  has_many :teachers, through: :enrollments
  has_many :students, through: :enrollments

  validates :name,  presence: true
end
