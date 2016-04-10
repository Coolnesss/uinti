class Achievement < ActiveRecord::Base
  validates :title, presence: true

  has_many :user_achievements
  has_many :users, through: :user_achievements

  def completed_by?(user)
    users.include? user
  end

  def picture_url
    return unless poke_name
    PokeApi.find_picture poke_name
  end

  def to_s
    return poke_name.capitalize if poke_name
    "No pokemon"
  end

end
