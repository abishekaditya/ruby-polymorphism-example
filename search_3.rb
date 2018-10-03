#!/usr/bin/env ruby

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
             important_only: false,
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
      if important_only
        data
          .select { |d| d[:important] == true }
      else
        data
      end
    filtered.map { |x| x[:name] }
  end
end

db = Database.new(DATA)
puts db.search(search_str: 'carrot', type: 'tag', important_only: true)
