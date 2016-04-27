require 'uri'

class Achievement < ActiveRecord::Base
  validates :title, presence: true

  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  validate :validate_pokemon

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

  def validate_pokemon
    if poke_name.match(/\s/)
      errors.add(:poke_name, "doesn't seem to be real pokemon")
      return
    end
    errors.add(:poke_name, "doesn't seem to be valid") unless PokeApi.validate_name(poke_name)
  end

end
