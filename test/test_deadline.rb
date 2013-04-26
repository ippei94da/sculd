#! /usr/bin/env ruby
# coding: utf-8

require "helper"

class TC_Deadline < Test::Unit::TestCase
  def setup
    today = Date.new(2012, 10, 15)
    @d00 = Sculd::Plan::Deadline.new(today, 10, '[2012-10-15]!10 deadlineA')
  end

  #context 'Date[2012-10-15], 10, [2012-10-15]!10 deadlineA' do

  def test_priority
    today = Date.new(2012, 10, 15)
    assert_equal(20000, @d00.priority(today))

    today = Date.new(2012, 10, 20)
    assert_equal(20000, @d00.priority(today))

    today = Date.new(2012, 10, 10)
    assert_equal(15000, @d00.priority(today))

    today = Date.new(2012, 10,  1)
    assert_equal(0, @d00.priority(today))
  end

  def test_events
    assert_equal(2                     , @d00.events.size      )
    assert_equal(Date.new(2012, 10,  5), @d00.events[0].date   )
    assert_equal(Date.new(2012, 10, 15), @d00.events[1].date   )
  end

end
