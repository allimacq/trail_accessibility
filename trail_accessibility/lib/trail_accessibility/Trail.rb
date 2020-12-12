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
  
  def self.sort_by_length_for(state)
    sorted_by_length = Scraper.print_trails_for(state).sort_by {|trail| trail.distance.to_i}
    sorted_by_length.each_with_index do |trail, index|
      puts "#{index + 1}. #{trail.name}"
      puts "Rating: #{trail.rating}"
      puts "Distance: #{trail.distance} mi"
      puts "Surface Type(s): #{trail.surface}"
      puts "Brief Description: #{trail.info}\n"
      puts "--------------------------------------------------------------------------------\n"
    end
  end
    
  def sort_by_surface(type)
  end
  #need to write method to only show trails with a particular type of surface
  #need to write method to only show trails that have reviews
  
end