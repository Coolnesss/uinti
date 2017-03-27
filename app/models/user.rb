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

  def self.rank_ordered
    users = User.all.select {|u| u.rank != 0}
    users.sort_by {|u| u.rank.split("_").reverse.join}
  end

  def rank
    event_count = events_in_past_year
    return 0 if event_count == 0
    ranks[event_count-1]
  end

  def ranks
    ranks = []
    (2..14).each do |value|
      value = "0#{value}" if value < 10
      (1..4).each do |suit|
        ranks << "#{suit}_#{value}"
      end
    end
    ranks.flatten
  end

  def image_of_rank
    base_url = "https://www.cs.helsinki.fi/u/totalvit/warez/pc/"
    return base_url + "empty.png" if rank == 0
    base_url + "#{rank}.png"
  end

  private

  def events_in_past_year
    events.where("time > ?", 1.year.ago).count
  end
end
