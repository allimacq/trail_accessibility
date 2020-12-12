require 'nokogiri'
require 'open-uri'

require_relative "./Trail"

class Scraper
  
  @@states = []
  
  #this method gets all the states and a link to their page of accessibil trails. the return is an array of hashes.
  def self.get_states
    site = 'https://www.traillink.com/activity/wheelchair-accessible-trails/'
    page = Nokogiri::HTML(open(site))
    results = page.css("div.row.small-up-2.medium-up-3.large-up-4.block-grid div.column")
    
    #initializing an array to hold the hashes of states
    array = []
    
    results.each do |state|
      @@states << state.css("a").text.strip
      array << {
        state: state.css("a").text.strip,
        link: state.css("a").attribute("href").value
      }
    end
    
    #the website has other categories beyone states so using the take method to get just the states and dc
    states_array = array.take(51)
  end
  
  def self.display_indexed_states
    @@states.take(51).each_with_index do |state, index|
      puts "#{index + 1}. #{state}"
    end
  end
  
  def self.states
    @@states.take(51)
  end
      
  
  #this method gets the state trail page ready to scrape for the necessary info
  def self.get_requested(state)
    #using the find method to get the link to the user's requested state
    state_to_find = self.get_states.find {|h| h[:state] == "#{state}"}[:link]
    
    #this is the link that will be used with Nokogiri
    state_link = 'http://traillink.com' + state_to_find
    
    #opening the requested state's page
    state_page = Nokogiri::HTML(open(state_link))
    
    #getting the table of trails for requested state
    state_results = state_page.css('table.search-result-table tbody tr.search-result-card.hide-for-small-only')
  end
  
  #will use this method to create Trails 
  def self.make_state_trails(state)
    self.get_requested(state).collect do |state_trails|
      trail_instance = {name: "#{state_trails.css('td.info div a h3').text.strip}", state: "#{state}", surface: "#{state_trails.css('td.surface').text.strip}", distance: "#{state_trails.css('td.length').text.strip.scan(/[^ mi]/).join}"}
      trail = Trail.new(trail_instance)
      trail.link = state_trails.css("td.info div a").attribute("href").value
      #trail.name = state_trails.css("td.info div a h3").text.strip
      trail.info = state_trails.css("td.info div")[1].text
      #trail.state = state_trails.css("td.states").text.strip
      #trail.length = state_trails.css("td.length").text.strip
      #trail.surface = state_trails.css("td.surface").text.strip
      trail.rating = state_trails.css("td.rating div a").text.strip
      trail.rating_link = state_trails.css("td.rating div a").attribute("href").value
    end
  end
  
  #prints out info for all of the state's trails
  def self.print_trails_by_distance_for(state)
    puts "There are #{Trail.all.count} accessible trails in #{state}."
    sorted_by_distance = Trail.all.sort_by {|trail| trail.distance.to_i}
    sorted_by_distance.each_with_index do |trail, index|
      puts "#{index + 1}. #{trail.name}"
      puts "Rating: #{trail.rating}"
      puts "Distance: #{trail.distance} mi"
      puts "Surface Type(s): #{trail.surface}"
      puts "Brief Description: #{trail.info}\n"
      puts "--------------------------------------------------------------------------------\n"
    end
  end
  
  #need to write methods to:
  # -get link for a requested trail
  # -print info for requested trail
  #def self.get_requested_state(trail)
   # puts Trail.all.find {|trail| trail.name = '#{trail}'}[trail.link]
    #Nokogiri::HTML(open(trail_link))
    
  #end
  
  
  
end