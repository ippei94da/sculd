#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Sculd::Plan
  class NotDefinedError < Exception; end

  # Parse and return date, type, option.
  def self.parse(str)
    #/\[(\d{4})-(\d{2})-(\d{2})\]([@+!-])(\d*)/ =~ @line
    #/\[(\d{4})-(\d{2})-(\d{2})\]([@+!-])(\d*)(.*)$/ =~ @line
    #/\[\d{4}-\d{2}-\d{2}(?: \d{2}\:\d{2})?\][@+!-](\d*)(.*)/ =~ line
    str =~ /[(^]+)](.)(\S*)/
    #date      = DateTime::new($1.to_i, $2.to_i, $3.to_i)
    date      = DateTime::parse $1
    type      = $2
    option    = $3
    #string    = $6
    #results = {
    #  :date      => date
    #  :type      => type,
    #  :period    => period,
    #  :string    => string,
    #}
    return date, type, option
  end

  #
  def initialize(date, type, option, string)
    @date   = date
    @type   = type
    @option = option
    @string = string
  end

  # return priority of task calculated by equation defined in subclass. 
  def priority
    raise NotDefinedError
  end

  def to_events
    raise NotDefinedError
  end
end

