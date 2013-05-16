#! /usr/bin/env ruby
# coding: utf-8

#require "sculd/event.rb"

#
#
#
class Sculd::Plan::Schedule < Sculd::Plan

  SYMBOL_CHAR = "@"

  #
  def priority(today = Date.new)
    return 0
  end

  def event_dates
    [Date.new(@datetime.year, @datetime.month, @datetime.day)]
  end
end

