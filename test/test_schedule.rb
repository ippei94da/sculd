#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Schedule < Test::Unit::TestCase
  def setup
    date = Date.new(2012, 10, 15)
    @s00 = Sculd::Plan::Schedule.new(date, false,  0, "scheduleA")

    date = DateTime.new(2012, 10, 15, 23, 45, 0)
    @s01 = Sculd::Plan::Schedule.new(date, false,  0, "scheduleA")
  end

  def test_priority
    #it 'should return 0' do
    assert_equal(0, @s00.priority)
  end

  def test_event_dates
    #it 'should return Array of 1 item' do
    results = @s00.event_dates
    assert_equal([Date.new(2012, 10, 15)], results)

    results = @s01.event_dates
    assert_equal([Date.new(2012, 10, 15)], results)
  end
end
