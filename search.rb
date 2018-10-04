#!/usr/bin/env ruby

# Simple suffix search to be implemented

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
# simple suffix search
class Database
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def search(str)
    @data
      .select { |d| d[:name] =~ /.+#{str}/ }
      .map { |d| d[:name] }
  end
end

db = Database.new(DATA)
puts db.search('ke')
