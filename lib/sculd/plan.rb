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

  attr_reader :description

  REMINDER_PRIORITY = 10000
  DEADLINE_PRIORITY = 20000

  # Parse and return date, type, option.
  def self.parse(str)
    #/\[([\d\- :]*)\](.)(\S*)/ =~ str #OK
    /\[([^\]]*)\](.)(\S*)/ =~ str #OK

    datestr = $1
    type    = $2
    option  = $3.to_s

    datetime      = DateTime::parse datestr
    if /\((.+)\)/ =~ datestr
      raise WeekdayMismatchError unless self.wday($1) == datetime.wday
    end
    return datetime, type, option
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
  def initialize(datetime, option, description)
    @datetime   = datetime
    @option = option
    @description = description
  end

  # return priority of task calculated by equation defined in subclass. 
  def priority
    raise NotDefinedError
  end

  def events
    raise NotDefinedError
  end
end

