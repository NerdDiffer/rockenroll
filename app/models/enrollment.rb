class Enrollment < ActiveRecord::Base
  include Personable

  belongs_to :course, inverse_of: :enrollments

  belongs_to :teacher, class_name: 'Person'
  belongs_to :student, class_name: 'Person'

  has_many :lessons,
    foreign_key: 'enrollment_id',
    class_name: 'Meeting'

  validates :course,  presence: true
  validates :teacher, presence: true
  validates :student, presence: true
  validate :different_teacher_and_student

  class << self
    def enrollments_for_person(person_id)
      collection_for_person(person_id)
    end

    private

    def _collection_for_person(person_id)
      person_matches = teacher_id_or_student_id_matches(person_id)
      where(person_matches)
        .distinct
    end
  end

  private

  def different_teacher_and_student
    if teacher_and_student_same?
      msg = 'Student & Teacher must be two different people'
      errors.add(:base, msg)
    end
  end

  def teacher_and_student_same?
    teacher_id == student_id
  end
end
