#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Schedule < Test::Unit::TestCase
  def setup
    date = Date.new(2012, 10, 15)
    @s00 = Sculd::Plan::Schedule.new(date, 0, "[2012-10-15]@ scheduleA")
  end

  def test_priority
    #it 'should return 0' do
    assert_equal(0, @s00.priority)
  end

  def test_events
    #it 'should return Array of 1 item' do
    assert_equal(Array, @s00.events.class)
    assert_equal(1 , @s00.events.size)
    assert_equal(Date.new(2012, 10, 15), @s00.events[0].date)
  end
end
