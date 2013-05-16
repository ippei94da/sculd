#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Klass < Test::Unit::TestCase
  def setup
    date = Date.new(2012, 10, 23)
    @r00 = Sculd::Plan::Reminder.new(date, false, 10, 'reminderA')

    date = DateTime.new(2012, 10, 23, 23, 45, 00)
    @r01 = Sculd::Plan::Reminder.new(date, false, 10, 'reminderA')
  end

  def test_priority
    #it 'return REMINDER_PRIORITY when the day is today .' do
    date = Date.new(2012, 10, 23)
    assert_equal(10000, @r00.priority(date))

    #it 'return REMINDER_PRIORITY -1 when the day is yesterday .' do
    date = Date.new(2012, 10, 24)
    assert_equal(9999, @r00.priority(date))
  end

  def test_event_dates
    #it 'return a Sculd::Event instance.' do
    results = @r00.event_dates
    assert_equal([Date.new(2012, 10, 23)], results)

    results = @r01.event_dates
    assert_equal(1                     , results.size)
    assert_equal(Date.new(2012, 10, 23), results[0]  )
    assert_equal(Date                  , results[0].class  )
  end
end

