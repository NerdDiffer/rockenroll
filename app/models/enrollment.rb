class Enrollment < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher
  belongs_to :student
end
