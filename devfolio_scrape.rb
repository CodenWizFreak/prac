require 'open-uri'
require 'nokogiri'

# Unstop URL (replace with the Unstop hackathons page URL)
url = 'https://unstop.com/hackathons'

# Open the webpage and read the HTML content
html_content = URI.open(url)

# Parse the HTML content using Nokogiri
doc = Nokogiri::HTML(html_content)

# Example: Extract hackathon titles and links
hackathons = doc.css('a[href^="/hackathons/"]') # CSS selector for hackathon links
puts "Unstop Hackathons:"
hackathons.each_with_index do |hackathon, index|
  title = hackathon.text.strip
  link = 'https://unstop.com' + hackathon['href']
  puts "#{index + 1}. #{title} - #{link}"
end
