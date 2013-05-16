#! /usr/bin/env ruby
# coding: utf-8

#require "sculd/event.rb"
#require "sculd/plan.rb"

#
#
#
class Sculd::Plan::Deadline < Sculd::Plan

  SYMBOL_CHAR = "!"
  DEFAULT_OPTION = 7

  def priority(today)
    #@option = 1 if @option < 1
    beginning = @datetime - (@option || DEFAULT_OPTION)
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

  def event_dates
    #@option ||= DEFAULT_OPTION

    results = []
    results << @datetime - (@option || DEFAULT_OPTION)
    results << @datetime
    results.map do |datetime|
      Date.new(datetime.year, datetime.month, datetime.day)
    end
  end
end

