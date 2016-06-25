#! /usr/bin/env ruby

require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'csv'

page = HTTParty.get('http://www.hostelworld.com/hostels/San-Francisco')
nokogiri_page = Nokogiri::HTML(page)
prices_array = []

nokogiri_page.css('span.price').each do |price|
  price = price.text.delete('€, ')  
  prices_array.push(price.to_i)
end

prices_array.delete(0)
prices_array = prices_array.select.with_index { |_, i| i.odd? }

CSV.open('sanfrancisco.csv', 'w') do |csv|
  csv << prices_array
end 

