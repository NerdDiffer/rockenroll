class MeetingDecorator < ApplicationDecorator
  delegate_all
  decorates_association :course

  def allowed_lengths
    numbers = lengths.values
    numbers.map(&:to_i)
  end

  def available_rooms
    all_rooms = fetch_all_rooms
    all_rooms.each_with_object({}) do |(room), rooms_collection|
      collect(room, rooms_collection)
    end
  end

  def link_to_course
    h.link_to(course_name, course) if course_id?
  end

  def link_to_room
    h.link_to(room_name, course) if room_id?
  end

  def course_name
    course.name if course_id?
  end

  def room_name
    room.name if room_id?
  end

  def course_enrollments
    if course_id?
      h.render 'course_enrollments'
    else
      h.content_tag(:p, 'There is no attached course for this meeting.')
    end
  end

  def display_length
    "#{length_to_i} minutes" if length?
  end

  private

  def lengths
    object.class.lengths
  end

  def fetch_all_rooms
    Room.all
  end

  def collect(room, rooms_collection)
    name = room.name.to_s
    id   = room.id
    rooms_collection[name] = id
    rooms_collection
  end
end
