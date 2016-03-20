class Course < ActiveRecord::Base
  has_many :enrollments, inverse_of: :course
  has_many :meetings,    inverse_of: :course
end
