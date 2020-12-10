require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  @@states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennslyvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
  
  def self.display_indexed_states
    @@states.each_with_index do |state, index|
      puts "#{index + 1}. #{state}"
    end
  end
  
  def call
    puts "Welcome!"
    puts "Which State would you like to explore for accessible trails?"
    TrailAccessibility::CLI.display_indexed_states
    Scraper.get_states
    state = gets.strip
    puts "\nPlease note that, unfortunately, the definition of accessible is not uniform. Read trail reviews and go to their official website for the most up-to-date information.\n\n"
    Scraper.get_requested(state)
    Scraper.make_state_trails(state)
    Scraper.print_trails_for(state)
    puts "If you would like to see more about a particular trail, please type in its number"
  end
  
end