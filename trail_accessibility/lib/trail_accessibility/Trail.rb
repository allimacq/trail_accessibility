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
    sorted_by_length = Scraper.print_trails_for(state).sort_by {|trail| trail.distance}
    #sorted_by_length.each_with_index do |trail, index|
     # puts "#{index + 1}. #{trail.name}"
      #puts "Rating: #{trail.rating}"
      #puts "Distance: #{trail.distance}"
      #puts "Surface Type(s): #{trail.surface}"
      #puts "Brief Description: #{trail.info}\n"
      #puts "--------------------------------------------------------------------------------\n"
    #end
    sorted_by_length.each do |trail|
      p trail.distance
      #need to convert from string to integer
    end
  end
    
  #need to write method to sort trails by distance
  #need to write method to only show trails with a particular type of surface
  #need to write method to only show trails that have reviews
  
end