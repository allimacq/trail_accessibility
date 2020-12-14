require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  attr_accessor :state
  
  def self.welcome_message
    puts "Welcome!"
    puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
  end
    
  
  def self.display_options
   Scraper.display_indexed_states
  end
  
  def self.user_choose_state
    puts "\nWhich State would you like to explore for accessible trails? Please enter the corresponding number:"
    number = gets.strip.to_i
    until number > 0 && number < 52
      puts "Please enter a number between 1 and 51:"
      number = gets.strip.to_i
    end
    @state = Scraper.states[number - 1]
  end
  
  def self.make_requested_state
    Scraper.get_requested(@state)
    Trail.clear
    Scraper.make_state_trails(@state)
  end
  
  def self.display_asphalt?
    puts "Would you like to only see trails made of Asphalt? (Y/N)"
    answer = gets.strip.capitalize
    if answer == 'Y'
      Trail.view_only_asphalt_trails
    end
  end
  
  def self.display_trails_for_state
    Scraper.print_trails_by_distance_for(@state)
    TrailAccessibility::CLI.display_asphalt?
  end
  
  def self.verification_of(input)
    until input >= 0 && input <= Trail.trails_in(@state).count
      puts "Please enter a number between 1 and #{Trail.trails_in(@state).count}"
      input = gets.strip.to_i
    end
    #goes to list of states if not a valid integer input
    if input.class != Integer
      input = 0
    end
    input
  end
  
  def self.get_trail_number
    puts "If you would like to see more about a particular trail, please type in its corresponding number or 0 to view State list."
    input = gets.strip.to_i
    TrailAccessibility::CLI.verification_of(input)
  end
  
   def self.view_requested_trail
    if self.get_trail_number > 0
      trail = Scraper.print_trails_by_distance_for(@state)[self.get_trail_number - 1]
      Scraper.get_requested_info_for(trail)
      Scraper.print_requested(trail)
      puts "\n\nType 1 if you would you like to view a different trail in #{@state} or type 2 if would you like to explore another State. Otherwise, type 0 to exit."
    end
  end
  
  def self.input_at_end
    number = gets.strip.to_i
    if number.class(Integer) == false
      number = 0
    end
    number
  end
    
  
  
  def call
    number = 1
    TrailAccessibility::CLI.welcome_message
    Scraper.get_states
    #until number == 0
      TrailAccessibility::CLI.display_options
      TrailAccessibility::CLI.user_choose_state
      TrailAccessibility::CLI.make_requested_state
      TrailAccessibility::CLI.display_trails_for_state
      number = TrailAccessibility::CLI.get_trail_number
      if number > 0
        TrailAccessibility::CLI.view_requested_trail
       #number = TrailAccessibility::CLI.input_at_end
      end
  end
  
end