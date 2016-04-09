require 'rest-client'

class PokeApi
  @url = "http://pokeapi.co/api/v2/"


  def self.find(name)
    JSON.parse(Rails.cache.fetch(name, expires_in: 1.week) { get_pokemon(name) })
  end

  def self.find_picture(name)
    response = find(name)
    response["sprites"]["front_default"] if response
  end

  def self.all
    Rails.cache.fetch("all", expires_in: 1.week) { fetch_all }
  end

  def self.fetch_all
    response = RestClient.get @url + "pokemon", 'rack-cache.disable_digest_header' => false
    JSON.parse(response)
  end

  def self.get_pokemon(name)
    # Fixing bug in RestClient(?)
    String.new(RestClient.get(@url + "pokemon/#{name}"))
  end

end
