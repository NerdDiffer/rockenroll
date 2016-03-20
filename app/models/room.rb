class Room < ActiveRecord::Base
  has_many :meetings, inverse_of: :room
end
