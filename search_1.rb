#!/usr/bin/env ruby

# Important filter needs to be added

require_relative './loader.rb'
DATA = load_data

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
