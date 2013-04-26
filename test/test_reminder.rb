#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Klass < Test::Unit::TestCase
  def setup
    date = Date.new(2012, 10, 23)
    @r00 = Sculd::Plan::Reminder.new(date, 10, '[2012-10-23]- reminderA')
  end

  def test_priority
    #it 'return REMINDER_PRIORITY when the day is today .' do
    date = Date.new(2012, 10, 23)
    assert_equal(10000, @r00.priority(date))

    #it 'return REMINDER_PRIORITY -1 when the day is yesterday .' do
    date = Date.new(2012, 10, 24)
    assert_equal(9999, @r00.priority(date))
  end

  def test_events
    #it 'return a Sculd::Event instance.' do
    result = @r00.events
    assert_equal(Array, result.class)
    assert_equal(1, result.size)
    assert_equal(Sculd::Event, result[0].class)
    assert_equal(Date.new(2012, 10, 23), result[0].datetime.to_date)
  end
end

