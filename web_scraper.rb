#!/usr/bin/env ruby
require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'

# This is how we request the page we are going to scrape
#page = HTTParty.get('http://www.climatempo.com.br/previsao-do-tempo/cidade/558/saopaulo-sp')
page = HTTParty.get('https://newyork.craigslist.org/search/pet?s=0')


# This is where we transform our HTTP reponse into a Nokogiri object
parse_page = Nokogiri::HTML(page)

# This is an empty array where we will store all our responses
pets_array = []

# This is where we parse the page
#parse_page.css('#tbl-horaria').css('thead').css('tr')
#parse_page.css('.line-tbl-horaria')#tbl-horaria > thead > tr > th:nth-child(1)
#parse_page.css('.content').css('.row').css('.pnr')
#parse_page.css('.content').css('.row').css('.txt').css('.pnr').css('small')

parse_page.css('.content').css('.row').css('.txt').css('.pnr').css('small').map do |a|
  post_name = a.text
  pets_array.push(post_name)
end

CSV.open('pets.csv', 'w') do |csv|
  csv << pets_array
end

# Pry.start(binding)
