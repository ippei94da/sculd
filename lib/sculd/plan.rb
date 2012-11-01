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

  attr_reader :description

  REMINDER_PRIORITY = 10000
  DEADLINE_PRIORITY = 20000

  # Parse and return date, type, option.
  def self.parse(str)
    #/\[([\d\- :]*)\](.)(\S*)/ =~ str #OK
    /\[([^\]]*)\](.)(\S*)/ =~ str #OK

    datetime      = DateTime::parse $1
    type      = $2
    option    = $3.to_s
    if /\(.*\)/ =~ $1
      raise WeekdayMismatchError unless self.wday($1) == datetime.wday
    end
    return datetime, type, option
  end

  def self.wday(str)
    case str
    when /^Su/
      return 0
    when /^M/
      return 1
    when /^Tu/
      return 2
    when /^W/
      return 3
    when /^Th/
      return 4
    when /^F/
      return 5
    when /^Sa/
      return 6
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

