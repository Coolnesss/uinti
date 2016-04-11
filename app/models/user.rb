class User < ActiveRecord::Base
  has_secure_password
  validates :username, uniqueness: true

  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements

  def to_s
    username.capitalize
  end
end
