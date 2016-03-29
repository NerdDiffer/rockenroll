class PersonDecorator < Draper::Decorator
  delegate_all

  def full_name
    first_name + ' ' + last_name
  end

  def first_name_plus_initial
    first_name + ' ' + last_name[0] + '.'
  end

  def show_enrollments
    if enrollments.any?
      h.render 'enrollments'
    else
      h.content_tag :p, "There are no enrollments for #{first_name}."
    end
  end

  def show_students
    h.render 'students' if students.any?
  end

  def show_teachers
    h.render 'teachers' if teachers.any?
  end
end
