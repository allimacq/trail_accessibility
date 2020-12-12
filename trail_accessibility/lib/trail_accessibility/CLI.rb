require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  
  def call
    puts "Welcome!"
    Scraper.get_states
    Scraper.display_indexed_states
    puts "Which State would you like to explore for accessible trails? Please enter the corresponding number:"
    #asking for number input, getting rid of whitespace and converting to an integer
    number = gets.strip.to_i
    #using the index of states to retrieve the proper state
    state = Scraper.states[number - 1]
    puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
    Scraper.get_requested(state)
    Scraper.make_state_trails(state)
    Scraper.print_trails_by_distance_for(state)
    puts "If you would like to see more about a particular trail, please type in its number"
    #self.get_requested_state(trail)
  end
  
end