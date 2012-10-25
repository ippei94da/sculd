#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"
require "sculd/plan.rb"

#
#
#
class Sculd::Plan::Reminder < Sculd::Plan
  # value of @option does not work
  def priority(today = Date.now)
    if today < @datetime
      return 0
    else
      #@option = 1 if @option < 1
      return Sculd::Plan::REMINDER_PRIORITY - (today - @datetime) #/@option
    end
  end

  def events
    return [Sculd::Event.new(@datetime, @description)]
  end
end

