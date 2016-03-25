class Meeting < ActiveRecord::Base
  belongs_to :course, inverse_of: :meetings
  belongs_to :room,   inverse_of: :meetings

  enum length: {
    twenty_minute:       '20',
    thirty_minute:       '30',
    forty_five_minute:   '45',
    sixty_minute:        '60',
    seventy_five_minute: '75',
    ninety_minute:       '90'
  }

  validate :start, :acceptable_starting_time?

  def stop
    return unless start?
    return unless length?

    start + length_to_i.minutes
  end

  def length_to_i
    self.class.lengths[length].to_i
  end

  private

  def acceptable_starting_time?
    message =  'The minute in the starting time must be a 0 or a 5. ie: '
    message += '3:00, 3:05, 3:10, 3:15, 3:20, 3:25, 3:30 etc.'
    errors.add(:start, message) unless divisible_by_5
  end

  def divisible_by_5
    start.min % 5 == 0
  end
end
