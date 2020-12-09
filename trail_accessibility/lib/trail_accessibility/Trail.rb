require_relative "./Scraper"

class Trail
  
  attr_accessor :state, :name, :link, :info, :description, :length, :surface, :rating, :rating_link
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def clear_all
    @@all.clear
  end
  
end