require 'nokogiri'
require 'open-uri'

require_relative './Park.rb'

class Scraper
  site = 'https://www.traillink.com/activity/wheelchair-accessible-trails/'
  page = Nokogiri::HTML(open(site))
  
  #this method scrapes the website to create and return a hash for each state containing the state name and its associated url for the site. 
  def self.get_states(site)
    results = page.css('div.row.small-up-2.medium-up-3.large-up-4.block-grid div.column')

    array = []

    results.each do |state|
      # storing the state and it's url in an array as an individual hash
      array << {
        # state name is the key
        state.css('a').text.strip => state.css('a').attribute('href').value
        # state url is the value
      }
    end

    # only want the states and DC links so using the take method to achieve this.
    state_array = array.take(51)
  end
  
  ##maybe I should make this all one method?
  
  #the list park method uses the array of hashes above to scrape for a list of accessible trails in that state.
  def self.list_parks(state_hash)
  end
  
end