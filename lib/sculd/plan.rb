#! /usr/bin/env ruby
# coding: utf-8

#require "sculd/plan/deadline.rb"
#require "sculd/plan/reminder.rb"
#require "sculd/plan/schedule.rb"
#require "sculd/plan/todo.rb"

#
#
#
class Sculd::Plan
  class NotDefinedError < Exception; end
  class WeekdayMismatchError < Exception; end
  class NotWeekdayError < Exception; end
  class NotNumberError < Exception; end

  attr_reader :description, :flag_time, :datetime, :option

  REMINDER_PRIORITY = 10000
  DEADLINE_PRIORITY = 20000

  # Parse and return date, type, option.
  def self.parse(str, io = $stdout)
    #/\[([\d\- :]*)\](.)(\S*)/ =~ str #OK
    /\[([^\]]*)\](.)(\S*)\s+(.*)/ =~ str #OK
    result = {}

    date, type, option, description = $1, $2, $3, $4

    datetime      = DateTime::parse date
    if /\((.+)\)/ =~ date
      unless self.wday($1) == datetime.wday
        io.puts "ERROR:"
        io.puts "#{datetime} is #{Sculd::Manager::WEEKDAYS[datetime.wday]},"
        io.puts "but string contains #{date}."
        raise WeekdayMismatchError
      end
    end
    result[:datetime] = datetime
    result[:flag_time] = date.include?(":")

    result[:type]   = type

    unless option.empty?
      raise NotNumberError unless option =~ /^[0-9]+$/
      result[:option] = option.to_i 
    end

    result[:description] = description

    return result
  end

  def self.wday(str)
    case str
    when /^Su/i
      return 0
    when /^M/i
      return 1
    when /^Tu/i
      return 2
    when /^W/i
      return 3
    when /^Th/i
      return 4
    when /^F/i
      return 5
    when /^Sa/i
      return 6
    else
      raise NotWeekdayError
    end
  end

  #
  def initialize(datetime, flag_time, option, description)
    @datetime    = datetime
    @flag_time   = flag_time
    @option      =  option
    @description = description
  end

  # return priority of task calculated by equation defined in subclass. 
  def priority
    raise NotDefinedError
  end

  def event_dates
    raise NotDefinedError
  end
end

