#! /usr/bin/env ruby
# coding: utf-8

#require "sculd/event.rb"
#require "sculd/plan.rb"

#
#
#
class Sculd::Plan::Todo < Sculd::Plan

  SYMBOL_CHAR = "+"
  DEFAULT_OPTION = 7

  #
  def priority(today)
    #@option = 1 if @option < 1
    option = @option || DEFAULT_OPTION
    beginning = @datetime
    ending    = @datetime + option
    if today < beginning
      return 0
    elsif today <= ending
      rp = Sculd::Plan::REMINDER_PRIORITY
      dp = Sculd::Plan::DEADLINE_PRIORITY
      return (rp + (dp - rp) * (today - beginning)/(option.to_f)).to_i
    else
      return Sculd::Plan::DEADLINE_PRIORITY
    end
  end

  def event_dates
    #@option ||= DEFAULT_OPTION

    results = []
    results << @datetime
    results << @datetime + (@option || DEFAULT_OPTION)
    results.map do |datetime|
      Date.new(datetime.year, datetime.month, datetime.day)
    end
  end
end

