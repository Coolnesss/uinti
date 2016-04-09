class Event < ActiveRecord::Base
  has_many :event_users
  has_many :users, through: :event_users

  validates :time, uniqueness: true

  validate :time_cannot_be_in_the_past

  def has_user?(user)
    users.include? user
  end

  def time_cannot_be_in_the_past
   if time.present? && time < Time.now
     errors.add(:time, "can't be in the past")
   end
  end

  def to_s
    diff = time - Time.now
    return "Happening in less than an hour" if diff < 1.hour
    return "Happening in less than a day" if diff < 24.hours
    return "Happening in #{time.days - Time.now}" if diff.abs < 30.days
  end



end
