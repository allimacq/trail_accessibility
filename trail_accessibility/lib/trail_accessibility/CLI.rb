require_relative "./Scraper"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  def call
    puts "Welcome!"
    puts "Which State would you like to explore for accessible trails?"
    puts "(Distric of Columbia is also an option!)\n\n"
    puts "Please note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information."
    Scraper.get_states
    state = gets.strip
    Scraper.get_requested(state)
    Scraper.make_state_trails(state)
    puts "Here is a list of accessible trails in #{state}:"
    Scraper.print_trails_for(state)
  end
  
end