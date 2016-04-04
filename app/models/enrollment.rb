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
end
