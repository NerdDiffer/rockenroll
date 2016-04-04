class Course < ActiveRecord::Base
  include Personable

  has_many :enrollments, inverse_of: :course
  has_many :meetings,    inverse_of: :course

  has_many :teachers, through: :enrollments
  has_many :students, through: :enrollments

  validates :name,  presence: true

  class << self
    def courses_for_person(person_id)
      collection_for_person(person_id)
    end

    private

    def _collection_for_person(person_id)
      person_matches = teacher_id_or_student_id_matches(person_id)
      joins(:enrollments)
        .where(person_matches)
        .distinct
    end
  end
end
