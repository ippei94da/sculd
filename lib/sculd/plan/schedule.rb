#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"

#
#
#
class Sculd::Plan::Schedule < Sculd::Plan
  #
  def priority(today = Date.new)
    return nil
  end

  def events
    return [Sculd::Event.new(@datetime, @description)]
  end
end

