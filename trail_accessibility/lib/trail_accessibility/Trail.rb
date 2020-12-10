require_relative "./Scraper"

class Trail
  
  attr_accessor :state, :name, :link, :info, :description, :length, :surface, :rating, :rating_link

  @@all = []
  
  def initialize(name:, state:, length:, surface:)
    @name = name
    @state = state
    @length = length
    @surface = surface
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.clear_all
    @@all.clear
  end
  
end