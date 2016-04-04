class Meeting < ActiveRecord::Base
  include Personable

  belongs_to :course, inverse_of: :meetings
  belongs_to :room,   inverse_of: :meetings
  belongs_to :enrollment

  MINUTE_INTERVAL = 5

  before_validation :round_start_down
  validate :start, :validate_start

  enum length: {
    twenty_minute:       '20',
    thirty_minute:       '30',
    forty_five_minute:   '45',
    sixty_minute:        '60',
    seventy_five_minute: '75',
    ninety_minute:       '90'
  }

  class << self
    def earliest_start
      @earliest_start ||= time_of_day.new(9, 0, 0)  # => 09:00:00
    end

    def latest_start
      @latest_start   ||= time_of_day.new(21, 0, 0) # => 21:00:00
    end

    private

    def time_of_day
      Tod::TimeOfDay
    end
  end

  class << self
    def lessons_for_person(person_id)
      collection_for_person(person_id)
    end

    private

    def _collection_for_person(person_id)
      person_matches = teacher_id_or_student_id_matches(person_id)
      joins(:enrollment)
        .where(person_matches)
        .distinct
    end
  end

  def stop
    return unless start?
    return unless length?

    start + length_to_i.minutes
  end

  def length_to_i
    self.class.lengths[length].to_i
  end

  private

  def round_start_down
    return unless start?
    rounded_minute = round_minute_down(start.min)
    self.start = start.change(min: rounded_minute)
  end

  # Round down to nearest multiple of 5
  def round_minute_down(minute)
    remainder = minute % MINUTE_INTERVAL
    minute -= remainder
  end

  # Round up to nearest multiple of 5
  def round_minute_up(minute)
    remainder = minute % MINUTE_INTERVAL

    if remainder == 0
      minute
    else
      difference = MINUTE_INTERVAL - remainder
      minute += difference
    end
  end

  def validate_start
    return unless start?

    unless start_time_within_regular_business_hours?
      earliest = self.class.earliest_start.to_s
      latest   = self.class.latest_start.to_s
      message  = "must be between #{earliest} and #{latest}"
      errors.add(:start, message)
    end
  end

  def start_time_within_regular_business_hours?
    earliest = self.class.earliest_start.second_of_day
    latest   = self.class.latest_start.second_of_day
    seconds_since_midnight = start.seconds_since_midnight.to_i

    seconds_since_midnight.between?(earliest, latest)
  end
end
