require_relative "./Scraper"
require_relative "./Trail"

#using namespacing so we avoid overwriting anything.
class TrailAccessibility::CLI
  
  def call
    answer = false
    until answer == 0
      TrailAccessibility::CLI.welcome_message
      Scraper.get_states
      TrailAccessibility::CLI.display_options
      state = TrailAccessibility::CLI.user_choose_state
      TrailAccessibility::CLI.make_requested(state)
      TrailAccessibility::CLI.display_trails_for(state)
      trail = TrailAccessibility::CLI.get_trail_number_for(state)
      if trail <= Trail.trails_in(state).count
        TrailAccessibility::CLI.view_requested_trail(trail, state)
        answer = TrailAccessibility::CLI.ask_user
        if answer
      end
      answer
    end
  end
  
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
    state = Scraper.states[number - 1]
  end
  
  def self.make_requested(state)
    Scraper.get_requested(state)
    Trail.clear
    Scraper.make_state_trails(state)
  end
  
  def self.display_asphalt?
    puts "Would you like to only see trails made of Asphalt? (Y/N)"
    answer = gets.strip.capitalize
    if answer == 'Y'
      Trail.view_only_asphalt_trails
    end
  end
  
  def self.display_trails_for(state)
    Scraper.print_trails_by_distance_for(state)
    TrailAccessibility::CLI.display_asphalt?
  end
  
  
  def self.get_trail_number_for(state)
    puts "If you would like to see more about a particular trail, please type in its corresponding number or enter any number above #{Trail.trails_in(state).count} to view State list."
    input = gets.strip.to_i
    until input > 0 && input <= Trail.trails_in(state).count + 1
      puts "Please enter a valid input: "
      input = gets.strip.to_i
    end
    input
  end
  
  def self.view_requested_trail(trail, state)
    trail_to_view = Trail.by_distance_in(state)[trail - 1]
    Scraper.get_requested_info_for(trail_to_view)
    puts "\n\n#{trail_to_view.name}\n"
    Scraper.print_requested(trail_to_view)
  end
    
  def self.ask_user
    puts "\n\nType 1 if you would you like to explore another state or type 2 to view a different trail in #{@state}. Otherwise, type 0 to exit."
    input = gets.strip.to_i
    until input >= 0 && input <= 2
      puts "Please enter 0, 1, or 2: "
      input = gets.strip.to_i
    end
    input
  end
  
end