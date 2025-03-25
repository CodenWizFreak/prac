require 'open-uri'
require 'nokogiri'

# Unstop URL (replace with the Unstop hackathons page URL)
url = 'https://unstop.com/hackathons'

# Open the webpage and read the HTML content
html_content = URI.open(url)

# Parse the HTML content using Nokogiri
doc = Nokogiri::HTML(html_content)

