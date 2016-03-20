class Meeting < ActiveRecord::Base
  belongs_to :course
  belongs_to :room

  enum length: {
    twenty_minute:       '20',
    thirty_minute:       '30',
    forty_five_minute:   '45',
    sixty_minute:        '60',
    seventy_five_minute: '75',
    ninety_minute:       '90'
  }
end
