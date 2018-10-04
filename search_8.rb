#!/usr/bin/env ruby

# Removing the hashes
require_relative './loader.rb'
DATA = load_data

# suffix search
class Suffix
  def self.search(data, str)
    data.select { |d| d[:name] =~ /.+#{str}/ }
  end
end

# tag search
class Tag
  def self.search(data, str)
    data.select { |d| d[:tags].include?(str) }
  end
end

# description search
class Description
  def self.search(data, str)
    data.select { |d| d[:desc] =~ /.+#{str}.+/ }
  end
end

# important filter
class ImportantFilter
  def self.filter(data)
    data.select { |d| d[:important] }
  end
end

# no filter
class NoFilter
  def self.filter(data)
    data
  end
end

# number of tags filter
class TagsFilter
  def self.filter(data)
    data.select { |d| d[:tags].length > 2 }
  end
end

# simple search
class Database
  def initialize(data: DATA, type: Suffix, filter: NoFilter)
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

tag_db = Database.new(data: DATA, type: Tag, filter: TagsFilter)
puts tag_db.search(search_str: 'carrot')
