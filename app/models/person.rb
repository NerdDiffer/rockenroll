class Person < ActiveRecord::Base
  has_one :account, class_name: 'User', inverse_of: :person

  has_many :enrollments_as_teacher,
    foreign_key: 'teacher_id',
    class_name: 'Enrollment',
    inverse_of: :teacher
  has_many :students, through: :enrollments_as_teacher

  has_many :enrollments_as_student,
    foreign_key: 'student_id',
    class_name: 'Enrollment',
    inverse_of: :student
  has_many :teachers, through: :enrollments_as_student

  has_many :courses_as_teacher,
    through: :enrollments_as_teacher,
    source: :course
  has_many :courses_as_student,
    through: :enrollments_as_student,
    source: :course

  has_many :lessons_as_teacher,
    through: :enrollments_as_teacher,
    source: :lessons
  has_many :lessons_as_student,
    through: :enrollments_as_student,
    source: :lessons

  def enrollments
    Enrollment.enrollments_for_person(id)
  end

  def courses
    Course.courses_for_person(id)
  end

  def lessons
    Meeting.lessons_for_person(id)
  end

  def lessons_within(lower_bound, upper_bound)
    lessons.select { |lesson| overlaps?(lesson, lower_bound, upper_bound) }
  end

  def scheduled?(lower_bound, upper_bound)
    lessons.any? { |lesson| overlaps?(lesson, lower_bound, upper_bound) }
  end

  def available?(lower_bound, upper_bound)
    lessons.none? { |lesson| overlaps?(lesson, lower_bound, upper_bound) }
  end

  private

  def overlaps?(lesson, lower_bound, upper_bound)
    lesson.overlaps?(lower_bound, upper_bound)
  end
end
