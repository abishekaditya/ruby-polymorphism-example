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
# search with important only
class Database
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def search(suffix:, important_only: false)
    data =  @data.select { |d| d[:name] =~ /.+#{suffix}/ }
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
puts db.search(suffix: 'ake', important_only: true)
