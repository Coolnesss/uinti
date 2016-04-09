class User < ActiveRecord::Base
  has_secure_password
  validates :username, uniqueness: true

  has_many :event_users
  has_many :events, through: :event_users
end
