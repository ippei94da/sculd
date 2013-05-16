#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Todo < Test::Unit::TestCase
  def setup
    today = Date.new(2012, 10, 15)
    @t00 = Sculd::Plan::Todo.new(today, false, 10, 'todoA')

    today = DateTime.new(2012, 10, 15, 23, 45, 00)
    @t01 = Sculd::Plan::Todo.new(today, false, 10, 'todoA')
  end

  def test_priority
    #it 'return 0 before the period.' do
    today = Date.new(2012, 10,  1)
    assert_equal(0, @t00.priority(today))

    #it 'return REMINDER_PRIORITY when the day is today.' do
    today = Date.new(2012, 10, 15)
    assert_equal(10000, @t00.priority(today))

    #it 'return values between REMINDER_PRIORITY and DEADLINE_PRIORITY during the period.' do
    today = Date.new(2012, 10, 20)
    assert_equal(15000, @t00.priority(today))

    #it 'return DEADLINE_PRIORITY when the day is past.' do
    today = Date.new(2012, 10, 30)
    assert_equal(20000, @t00.priority(today))
  end

  def test_event_dates
    results = @t00.event_dates
    assert_equal(2, results.size)
    assert_equal(Date.new(2012, 10, 15), results[0])
    assert_equal(Date.new(2012, 10, 25), results[1])


    results = @t01.event_dates
    assert_equal(2                     , results.size)
    assert_equal(Date.new(2012, 10, 15), results[0]  )
    assert_equal(Date.new(2012, 10, 25), results[1]  )
    assert_equal(Date                  , results[0].class  )
    assert_equal(Date                  , results[1].class  )
  end
end

