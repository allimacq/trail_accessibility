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
  
  def self.clear
    @@all.clear
  end
  
  def print_trail_info
    puts "Rating: #{self.rating}"
    puts "Distance: #{self.distance} mi"
    puts "Surface Type(s): #{self.surface}"
    puts "Brief Description: #{self.info}\n"
    puts "--------------------------------------------------------------------------------\n"
  end
  
    
  def self.view_only_asphalt_trails
    Trail.all.each_with_index do |trail, index|
      if trail.surface == 'Asphalt'
        puts "#{index}. #{trail.name}"
        puts trail.print_trail_info
      end
    end
  end
  
  def self.trails_in(state)
    @@all.select { |trail| trail.state == state}
  end
  
  def self.by_distance_in(state)
    self.trails_in(state).sort_by { |trail| trail.distance.to_i}
 end
   
      
  
end