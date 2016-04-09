class Achievement < ActiveRecord::Base
  validates :title, presence: true

  def picture_url
    return unless poke_name
    PokeApi.find_picture poke_name
  end

  def to_s
    return poke_name.capitalize if poke_name
    "No pokemon"
  end

end
