require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  def call
    puts "Welcome!"
    puts "Which State would you like to explore for accessible trails?"
    puts "(District of Columbia is also an option!)\n\n"
    Scraper.get_states
    state = gets.strip
    puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
    Scraper.get_requested(state)
    Scraper.make_state_trails(state)
    Scraper.print_trails_for(state)
  end
  
end