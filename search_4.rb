#!/usr/bin/env ruby

# Separating the logic for searches

require_relative './loader.rb'
DATA = load_data

# simple search
class Database
  def initialize(data:, type: 'simple')
    class_map = {
      'simple' => Suffix,
      'desc' => Description,
      'tags' => Tag
    }.freeze

    @data = data
    @klass = class_map[type]
  end

  def search(search_str:, important_only: false)
    data = @klass.search(@data, search_str)
    filtered =
      if important_only
        data
          .select { |d| d[:important] == true }
      else
        data
      end
    filtered.map { |x| x[:name] }
  end

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
end

tag_db = Database.new(data: DATA, type: 'tags')
puts tag_db.search(search_str: 'egg')
