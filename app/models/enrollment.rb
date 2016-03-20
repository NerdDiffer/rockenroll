class Enrollment < ActiveRecord::Base
  belongs_to :course, inverse_of: :enrollment
  belongs_to :teacher
  belongs_to :student
end
