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
  
  #this method display the initial information about the selected State's trails
  def print_trail_info
    puts "Rating: #{self.rating}"
    puts "Distance: #{self.distance} mi"
    puts "Surface Type(s): #{self.surface}"
    puts "Brief Description: #{self.info}\n"
    puts "--------------------------------------------------------------------------------\n"
  end
  
   
  #will only display trails that have asphalt as their surface attribute 
  def self.view_only_asphalt_trails_in(state)
    Trail.by_distance_in(state).each_with_index do |trail, index|
      if trail.surface == 'Asphalt'
        puts "#{index}. #{trail.name}"
        puts trail.print_trail_info
      end
    end
  end
  
  #this method will give us all of the trails in a specific state
  def self.trails_in(state)
    @@all.select { |trail| trail.state == state}
  end
  
  #this method sorts trails in a state by distance
  def self.by_distance_in(state)
    self.trails_in(state).sort_by { |trail| trail.distance.to_f}
 end
   
      
  
end