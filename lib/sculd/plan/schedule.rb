#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"

#
#
#
class Sculd::Plan::Schedule
  #
  def priority
    return 0
  end

  def to_events
    Sculd::Event.new(@date, @string)
  end
end

