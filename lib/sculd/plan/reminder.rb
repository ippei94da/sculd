#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"

#
#
#
class Sculd::Plan::Reminder
  #
  def priority
    if Date.today < @date 
      return nil
    else
      @option = 1 if @option < 1
      return (Date.today - @day)/@option
    end
  end

  def to_events
    return [Sculd::Event.new(@date, @string)]
  end
end

