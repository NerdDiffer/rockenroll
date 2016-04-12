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

      def room_id
        @room_ids ||= Room.select(:id)
        @room_ids.sample.id
      end

      def meeting_length
        @meeting_lengths ||= Meeting.lengths.keys
        @meeting_lengths.sample
      end

      def meeting_start
        start_time = meeting_start_time
        start_date = meeting_start_date
        params = { hour: start_time.hour, min:  start_time.min }

        start_date.to_time.utc.change(params)
      end

      def enrollment_id
        @enrollments_ids ||= Enrollment.select(:id)
        @enrollments_ids.sample.id
      end

      private

      def meeting_start_date
        before = 30.days.ago
        after  = 30.days.from_now
        Faker::Date.between(before, after)
      end

      def meeting_start_time
        time_arr = parse_time(seconds_since_midnight)
        hour     = time_arr[0].to_i
        min      = time_arr[1].to_i
        Tod::TimeOfDay.new(hour, min)
      end

      def seconds_since_midnight
        @earliest_start ||= Meeting.earliest_start.second_of_day
        @latest_start   ||= Meeting.latest_start.second_of_day
        rand(@earliest_start..@latest_start)
      end

      def parse_time(seconds_since_midnight)
        time_obj = Time.at(seconds_since_midnight).utc
        time_str = time_obj.strftime('%H:%M')
        time_str.split(':')
      end
    end
  end
end
