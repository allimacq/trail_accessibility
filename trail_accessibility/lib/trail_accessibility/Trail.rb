require_relative "./Scraper"

class Trail
  
  attr_accessor :state, :name, :link, :info, :description, :length, :surface, :rating, :rating_link

  @@all = []
  
  def initialize(name:, state:, length:, surface:)
    @name = name
    @state = state
    @length = length
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
  
  def self.sort_by_length_for(state)
    to_sort = Scraper.print_trails_for(state)
    to_sort.sort_by {|trail| trail.length}
  end
    
  #need to write method to sort trails by distance
  #need to write method to only show trails with a particular type of surface
  #need to write method to only show trails that have reviews
  
end