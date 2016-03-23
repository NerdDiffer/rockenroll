module Seeds
  module CreateOne
    class << self
      def room!(name)
        Room.create!(name: name)
      end

      def course!(name)
        Course.create!(name: name)
      end

      def meeting!(start, length, associations = {})
        associations.merge!(start: start, length: length)
        Meeting.create!(associations)
      end

      def person!(first_name, last_name, birthdate = nil)
        Person.create!(first_name: first_name,
                       last_name: last_name,
                       birthdate: birthdate)
      end

      def enrollment!(student, teacher, course)
        Enrollment.create!(student: student,
                           teacher: teacher,
                           course: course)
      end
    end
  end
end
