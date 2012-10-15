#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Sculd::Job
  class NotDefinedError < Exception; end

  #def self.parse(str)
  #  /\[(\d{4})-(\d{2})-(\d{2})\]([@+!-])(\d*)(.*)$/ =~ @line
  #  date      = Date::new($1.to_i, $2.to_i, $3.to_i)
  #  type      = $4
  #  period    = $5.to_i
  #  string    = $6
  #  results = {
  #    :date      => date
  #    :type      => type,
  #    :period    => period,
  #    :string    => string,
  #  }
  #  return results
  #end

  #
  def initialize(date, day, string)
    @date = date
    @day = day
    @string = string
  end

  # return priority of task calculated by equation defined in subclass. 
  def priority
    raise NotDefinedError
  end
end

