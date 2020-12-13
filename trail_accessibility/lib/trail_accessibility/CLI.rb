require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  attr_accessor :state
  
  def self.verification_of(input)
  end
  
  def self.display_states
    Scraper.display_indexed_states
    puts "Which State would you like to explore for accessible trails? Please enter the corresponding number:"
    #asking for number input, getting rid of whitespace and converting to an integer
    number = gets.strip.to_i
    until number > 0 && number < 52
      puts "Please enter a number between 1 and 51:"
      number = gets.strip.to_i
    end
  end
  
  def self.display_state_trails
      number = self.display_states
     #using the index of states to retrieve the proper state
      @state = Scraper.states[number - 1]
      puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
      Scraper.get_requested(@state)
      Trail.clear
      Scraper.make_state_trails(@state)
      Scraper.print_trails_by_distance_for(@state)
  end
  
   def self.display_asphalt?
    puts "Would you like to only see trails made of Asphalt? (Y/N)"
    answer = gets.strip.capitalize
    if answer == 'Y'
      Trail.view_only_asphalt_trails
    end
  end
  
  def self.get_trail_number
    puts "If you would like to see more about a particular trail, please type in its corresponding number or 0 to view State list."
    input = gets.strip.to_i
    if input.class(Integer) == false
      input = 0
    elsif input <= 0 || input > Trail.trails_in(@state).count 
      puts "Please enter a number between 1 and #{Trail.trails_in(@state).count}"
      input = gets.strip.to_i
    end
    input
  end
  
  def self.display_trails_for_state
    self.display_asphalt?  
    trail_number = self.get_trail_number
    if trail_number > 0
      self.view_particular(trail_number)
    end
  end
  
  
  def self.view_particular(trail_number)
    trail = Scraper.print_trails_by_distance_for(@state)[trail_number - 1]
    Scraper.get_requested_info_for(trail)
    Scraper.print_requested(trail)
    puts "\n\nType 'Trail' if you would you like to view a different trail in #{@state} or type 'State' if would you like to explore another State. Otherwise, type 'Exit' to exit."
  end
  
  
  def call
    puts "Welcome!"
    Scraper.get_states
    #initializing variable
    final_input = '0'
    until final_input == 'Exit'
      TrailAccessibility::CLI.display_states
      TrailAccessibility::CLI.display_specifics
      final_input = gets.strip
      if final_input == 'Trail'
        TrailAccessibility::CLI.display_specifics
        final_input = gets.strip
      elsif final_input.to_i == 'State'
        Trail.all.clear
        TrailAccessibility::CLI.display_states
        TrailAccessibility::CLI.display_specifics
        final_input = gets.strip
      end
    end
  end
end