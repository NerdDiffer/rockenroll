class EnrollmentDecorator < ApplicationDecorator
  delegate_all
  decorates_association :teacher
  decorates_association :student

  def course_name
    course.name
  end

  def teacher_name
    teacher.first_name_plus_initial
  end

  def student_name
    student.first_name_plus_initial
  end
end
