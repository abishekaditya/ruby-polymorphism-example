#!/usr/bin/env ruby
require 'json'

def load_data
  file = File.read('./data.json')
  JSON.parse(file, :symbolize_names => true)
end
