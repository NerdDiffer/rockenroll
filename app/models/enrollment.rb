class Enrollment < ActiveRecord::Base
  belongs_to :course, inverse_of: :enrollments

  belongs_to :teacher, class_name: 'Person'
  belongs_to :student, class_name: 'Person'

  validates :course,  presence: true
  validates :teacher, presence: true
  validates :student, presence: true
end
