#! /usr/bin/env ruby
# coding: utf-8

require "sculd/event.rb"
require "sculd/plan.rb"

#
#
#
class Sculd::Plan::Deadline < Sculd::Plan

  def priority(today)
    @option = 1 if @option < 1
    beginning = @datetime - @option
    if today < beginning
      return 0
    elsif today <= @datetime
      rp = Sculd::Plan::REMINDER_PRIORITY
      dp = Sculd::Plan::DEADLINE_PRIORITY
      return (rp + (dp - rp) * (today - beginning)/(@option.to_f)).to_i
    else
      return Sculd::Plan::DEADLINE_PRIORITY
    end
  end

  def events
    results = []
    results << Sculd::Event.new(@datetime - @option, @description)
    results << Sculd::Event.new(@datetime, @description)
    return results
  end
end

