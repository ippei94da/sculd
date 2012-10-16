#! /usr/bin/env ruby
# coding: utf-8

require "sculd.rb"
#require "/home/ippei/devel/sculd/lib/sculd.rb"

#
#
#
class Sculd::Manager
  #
  def initialize(file)
    @source_file = file
    load_file(@source_file)
  end
  
  def self.parse_str(str)
  end

  # Show events in 'num' days from todary.
  def show_event(num)
    return if num == 0
    puts "Events:"
    @events.sort_by {|i| i.date}
    today = Date.new
    num.times do |i|
      date = today + i
      puts "  - " + date
      puts 
    end
  end

  # Show 'num' tasks of the highest priority.
  def show_task(num)
    return if num == 0
    puts "Tasks:"
    @tasks.sort_by {|i| i.priority}.reverse[0..(num-1)].each do |t|
      puts "  - " + t.string
    end
  end

  private

  # read, parse file and set data to @events and @tasks.
  def load_file(file)
    @jobs = []

    File.open(file, "r").readlines.each do |line|
      job = Sculd::Job.parse(line)
      @jobs << job if job
    end

  end

end

