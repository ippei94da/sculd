#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"

#
#
#
class Sculd::Plan::Deadline
  #
  def priority
    TODO
    if Date.today < @date 
      return nil
    else
      @option = 1 if @option < 1
      return (Date.today - @day)/(@option.to_i)
    end
  end

  def to_events
    results = []
    TODO
    #results << Sculd::Event.new(@date, @string)
    #results << Sculd::Event.new(@date, @string)
    return results
  end
end

