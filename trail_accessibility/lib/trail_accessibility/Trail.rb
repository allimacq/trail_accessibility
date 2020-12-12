require_relative "./Scraper"

class Trail
  
  attr_accessor :state, :name, :link, :info, :description, :distance, :surface, :rating, :rating_link

  @@all = []
  
  def initialize(name:, state:, distance:, surface:)
    @name = name
    @state = state
    @distance = distance
    @surface = surface
    if @@all.include?(self) == false
      @@all << self
    end
  end
  
  def self.all
    @@all
  end
  
  def self.clear_all
    @@all.clear
  end
  
    
  def sort_by_surface(type)
  end
  #need to write method to only show trails with a particular type of surface
  #need to write method to only show trails that have reviews
  
end