#!/usr/bin/env ruby

# Simple suffix search to be implemented
require_relative './loader.rb'
DATA = load_data

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
