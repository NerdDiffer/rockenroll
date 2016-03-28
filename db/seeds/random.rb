module Seeds
  module Random
    class << self
      def person_id
        @person_ids ||= Person.select(:id)
        @person_ids.sample.id
      end

      def course_id
        @course_ids ||= Course.select(:id)
        @course_ids.sample.id
      end
    end
  end
end
