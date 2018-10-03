#!/usr/bin/env ruby

# THIS ONE IS WHAT WOULD HAPPEN IF THE SEARCH_3 FILE WAS DIRECTLY MODIFIED ONCE
# WE FOUND OUT ABOUT THE TAG FILTER

DATA = [
  {
    name: 'Cake',
    important: true,
    desc: 'The tastiest snack',
    tags: %w[flour egg sugar]
  },
  {
    name: 'Veggies',
    important: true,
    desc: 'Yucky Stuff',
    tags: %w[carrot beets]
  },
  {
    name: 'Carrot Cake',
    important: false,
    desc: 'The tastiest snack just got better',
    tags: %w[flour egg sugar carrot]
  }
].freeze
# search by tag
class Database
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def search(search_str:,
             filter:,
             type: 'simple')
    data =
      if type == 'tag'
        @data.select { |d| d[:tags].include?(search_str) }
      elsif type == 'desc'
        @data.select { |d| d[:desc] =~ /.+#{search_str}.+/ }
      else
        @data.select { |d| d[:name] =~ /.+#{search_str}/ }
      end
    filtered =
      if filter == 'important'
        data
          .select { |d| d[:important] == true }
      elsif filter == 'tags'
        data
          .select { |d| d[:tags].length > 2 }
      else
        data
      end
    filtered.map { |x| x[:name] }
  end
end

db = Database.new(DATA)
puts db.search(search_str: 'carrot', type: 'tag', filter: 'tags')
