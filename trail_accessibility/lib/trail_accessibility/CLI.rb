require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  attr_accessor :state
  
  def self.display_states
    Scraper.display_indexed_states
    puts "Which State would you like to explore for accessible trails? Please enter the corresponding number:"
    #asking for number input, getting rid of whitespace and converting to an integer
    number = gets.strip.to_i
    #using the index of states to retrieve the proper state
    @state = Scraper.states[number - 1]
    puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
    Scraper.get_requested(@state)
    Scraper.make_state_trails(@state)
  end
  
  def self.display_specifics
    Scraper.print_trails_by_distance_for(@state)
    puts "Would you like to only see trails made of Asphalt?"
    answer = gets.strip
    if answer.capitalize == 'Yes'
      Trail.view_only_asphalt_trails
    end
     puts "If you would like to see more about a particular trail, please type in its corresponding number:"
    input = gets.strip.to_i
    trail = Scraper.print_trails_by_distance_for(@state)[input - 1]
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
      puts final_input == 'Trail'
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