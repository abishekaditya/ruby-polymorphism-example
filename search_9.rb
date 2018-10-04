#!/usr/bin/env ruby

# making the tags filter have a modifier

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

# suffix search
class Suffix
  def search(data, str)
    data.select { |d| d[:name] =~ /.+#{str}/ }
  end
end

# tag search
class Tag
  def search(data, str)
    data.select { |d| d[:tags].include?(str) }
  end
end

# description search
class Description
  def search(data, str)
    data.select { |d| d[:desc] =~ /.+#{str}.+/ }
  end
end

# important filter
class ImportantFilter
  def filter(data)
    data.select { |d| d[:important] }
  end
end

# no filter
class NoFilter
  def filter(data)
    data
  end
end

# number of tags filter
class TagsFilter
  def initialize(count: 0)
    @count = count
  end

  def filter(data)
    data.select { |d| d[:tags].length > @count }
  end
end

# simple search
class Database
  def initialize(data: DATA, type: Suffix, filter: NoFilter.new)
    @data = data
    @search_class = type
    @filter_class = filter
  end

  def search(search_str:)
    data = @search_class.search(@data, search_str)
    filtered = @filter_class.filter(data)
    filtered.map { |x| x[:name] }
  end
end

tag_db =
  Database.new(data: DATA,
               type: Tag.new,
               filter: TagsFilter.new(count: 2))

puts tag_db.search(search_str: 'carrot')
