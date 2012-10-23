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

  REMINDER_PRIORITY = 10000
  DEADLINE_PRIORITY = 20000

  # Parse and return date, type, option.
  def self.parse(str)
    #/\[(\d{4})-(\d{2})-(\d{2})\]([@+!-])(\d*)/ =~ @line
    #/\[\d{4}-\d{2}-\d{2}(?: \d{2}\:\d{2})?\][@+!-](\d*)(.*)/ =~ line
    #/\[\d{4}-\d{2}-\d{2}(?: \d{2}\:\d{2})?\][@+!-](\d*)(.*)/ =~ str
    #/\[(\d{4}-\d{2}-\d{2}(?: \d{2}\:\d{2})?\][@+!-](\d*)(.*)/ =~ str
    /\[(\d{4}-\d{2}-\d{2})\]([@+!-])(\S*)(.*)$/ =~ str
    #/\[(^]+)\](.)(\S*)/ =~ str 
    #date      = DateTime::new($1.to_i, $2.to_i, $3.to_i)
    datetime      = DateTime::parse $1
    type      = $2
    option    = $3.to_s
    return datetime, type, option
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

