class CourseDecorator < Draper::Decorator
  delegate_all
  decorates_association :enrollments
  decorates_association :meetings
end
