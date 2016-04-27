class Event < ActiveRecord::Base
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users

  validates :time, uniqueness: true
  validates :place, presence: true

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
    diff = time.in_time_zone("Helsinki") - Time.now
    return "Happening in less than an hour" if diff < 1.hour
    return "Happening in less than a day" if diff < 24.hours
    return "Happening in #{time.in_time_zone("Helsinki").days - Time.now}" if diff.abs < 30.days
  end

  def formatted_time
    time.in_time_zone("Helsinki").to_formatted_s(:long_ordinal)
  end



end
