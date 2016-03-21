class User < ActiveRecord::Base
  belongs_to :person, inverse_of: :account

  has_secure_password
end
