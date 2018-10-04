#!/usr/bin/env ruby

# Separating the logic for filters

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

CLASS_MAP = {
  'simple' => Suffix,
  'desc' => Description,
  'tags' => Tag
}.freeze

FILTER_MAP = {
  'none' => NoFilter,
  'important' => ImportantFilter
}.freeze

# simple search
class Database
  def initialize(data:, type: 'simple', filter: 'none')
    @data = data
    @search_class = CLASS_MAP[type]
    @filter_class = FILTER_MAP[filter]
  end

  def search(search_str:)
    data = @search_class.search(@data, search_str)
    filtered = @filter_class.filter(data)
    filtered.map { |x| x[:name] }
  end
end

tag_db = Database.new(data: DATA, type: 'tags', filter: 'none')
puts tag_db.search(search_str: 'egg')
