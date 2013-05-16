#! /usr/bin/env ruby
# coding: utf-8

require "date"
require "sculd.rb"

require "rubygems"
#gem     "highline"
require "highline"

#
#
#
class Sculd::Manager
  #WEEKDAYS = [ "日", "月", "火", "水", "木", "金", "土" ]
  WEEKDAYS = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]

  class LoadError < Exception; end

  #
  def initialize(dir, io = $stdout)
    @source_dir = dir
    @plans = []
    Dir.glob("#{@source_dir}/*").each do |file|
      load_file(file, io)
    end
  end

  def show(num_event, num_task, io = $stdout)
    show_events(num_event)
    show_tasks(num_task)
  end

  private

  # read, parse file and set data to @events and @tasks.
  def load_file(file, io = $stdio)

    File.open(file, "r").readlines.each_with_index do |line, index|
      begin
        date, type, option = Sculd::Plan.parse(line, io)
        option = option.to_i
        next unless type
        case type
        when "@"
          plan_type = Sculd::Plan::Schedule
        when "!"
          plan_type = Sculd::Plan::Deadline
          option = 7 if option == 0
        when "-"
          plan_type = Sculd::Plan::Reminder
        when "+"
          plan_type = Sculd::Plan::Todo
          option = 7 if option == 0
        else
          next
        end
        @plans << plan_type.new(date, option, line)
      rescue Sculd::Plan::WeekdayMismatchError
        io.puts "error occured at #{index}: #{line}"
        raise LoadError
      rescue
        # do nothing
      end
    end
  end

  # Show events in 'num' days from todary.
  def show_events(num, today = Date.today, io = $stdout)
    return if num == 0
    hl = HighLine.new($stdin, io)

    d_e = days_events
    io.puts "Events:"
    num.times do |i|
      date = today + i
      str = " #{date.to_s} #{WEEKDAYS[date.wday]} "

      case date.wday
      when 0
        hl.say("  <%= color('#{str}', :white, :on_red) %>")
      when 6
        hl.say("  <%= color('#{str}', :white, :on_blue) %>")
      else
        hl.say("  <%= color('#{str}', :white, :on_black) %>")
      end

      events = d_e[date]
      if events # if plan is not empty.
        #HIGHLINE.say("<%= color('red', :red) %>!")
        #HIGHLINE.say("  <%= color(#{date.to_s} #{WEEKDAYS[date.wday]}, :white, :red) %>")
        #hl.say("  <%= color('red', :red) %>!")
        #io.puts str
        events.sort_by{|i| i.datetime}.each do |event|
          #pp event
          io.puts "    #{event.description.strip}"
        end
      else
        io.puts "    (no plan)"
      end
      io.puts
    end
  end

  # Return a hash of dates and events.
  # The eventes generated from @schedules sorted by date and time.
  def days_events
    results = {}
    @plans.each do |plan|
      plan.events.each do |event|
        date = event.date
        results[date] ||= []
        results[date] << event
      end
    end
    return results
  end

  # Show 'num' tasks of the highest priority.
  def show_tasks(num, today = Date.today, io = $stdout)
    return if num == 0

    io.puts "Tasks:"
    plans = @plans.sort_by {|plan| plan.priority(today)}.reverse
    #pp plans

    num = plans.size if plans.size < num
    plans[0..(num-1)].each do |plan|
      io.puts "  #{plan.description.strip}"
    end
  end
end

