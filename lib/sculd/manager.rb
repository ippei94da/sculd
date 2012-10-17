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

  def show(num_event, num_task)
    show_event(num_event)
    show_task(num_task)
  end

  private

  # read, parse file and set data to @events and @tasks.
  def load_file(file)
    @jobs = []

    File.open(file, "r").readlines.each_with_index do |line, index|
      job = Sculd::Job.detect(line, index)
      @jobs << job if job
    end
  end

  # Return a hash of dates and events.
  # The eventes generated from @jobs sorted by date and time.
  def days_events
    return @jobs.map{|job| job.to_events}.flatten.sort_by {|job|
      job.datetime
    }
  end

  def categorize_date(jobs)
    
  end

  # Show events in 'num' days from todary.
  def show_event(num)
    events.

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

end

