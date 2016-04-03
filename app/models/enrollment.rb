class Enrollment < ActiveRecord::Base
  belongs_to :course, inverse_of: :enrollments

  belongs_to :teacher, class_name: 'Person'
  belongs_to :student, class_name: 'Person'

  has_many :lessons,
    foreign_key: 'enrollment_id',
    class_name: 'Meeting'

  validates :course,  presence: true
  validates :teacher, presence: true
  validates :student, presence: true

  class << self
    def enrollments_for_person(person_id)
      if is_integer_ish?(person_id)
        where('student_id = ? OR teacher_id = ?', person_id, person_id)
      end
    end

    private

    def is_integer_ish?(value)
      value.to_i == value
    end
  end
end
