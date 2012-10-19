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

  def show(num_event, num_task)
    show_event(num_event)
    show_task(num_task)
  end

  private

  # read, parse file and set data to @events and @tasks.
  def load_file(file)
    @plans = []

    File.open(file, "r").readlines.each_with_index do |line, index|
      date, type, option = Sculd::Plan.parse(line)
      case type
      when "@"; plan_type = Sculd::Plan::Schedule
      when "!"; plan_type = Sculd::Plan::Deadline
      when "-"; plan_type = Sculd::Plan::Reminder
      when "+"; plan_type = Sculd::Plan::Todo
      else
        next
      end
      @plans << plan_type.new(date, option, line)
    end
  end

  # Show events in 'num' days from todary.
  def show_event(num)
    return if num == 0

    events = days_events
    today = Date.new
    puts "Events:"
    num.times do |i|
      date = today + i
      events[date].sort.each do |job|
        puts job.to_s
      end
    end
  end

  # Return a hash of dates and events.
  # The eventes generated from @schedules sorted by date and time.
  def days_events
    events = @plans.map{|plan| plan.to_events}.flatten
    results = {}
    events.each do |event|
      date = event.date
      results[date] ||= []
      results[date] << event
    end
    return results
  end

  # Show 'num' tasks of the highest priority.
  def show_task(num)
    return if num == 0
    puts "Tasks:"
    plans = @plans.sort_by {|plan| plan.priority}.reverse
    plans[0..(num-1)].each do |plan|
      puts "  - " + plan.string
    end
  end
end

