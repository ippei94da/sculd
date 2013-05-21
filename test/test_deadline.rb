#! /usr/bin/env ruby
# coding: utf-8

require "helper"

class TC_Deadline < Test::Unit::TestCase
  def setup
    date = Date.new(2012, 10, 15)
    @d00 = Sculd::Plan::Deadline.new(date, false, 10, 'deadlineA')

    date = DateTime.new(2012, 10, 15, 23, 45, 00)
    @d01 = Sculd::Plan::Deadline.new(date, false, 10, 'deadlineA')

    date = Date.new(2012, 10, 15)
    @d02 = Sculd::Plan::Deadline.new(date, false, nil, 'deadlineA')
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


    today = Date.new(2012, 10,  1)
    assert_equal(    0, @d02.priority(today))

    today = Date.new(2012, 10,  8)
    assert_equal(10000, @d02.priority(today))

    today = Date.new(2012, 10, 10)
    assert_equal(12857, @d02.priority(today))

    today = Date.new(2012, 10, 15)
    assert_equal(20000, @d02.priority(today))

    today = Date.new(2012, 10, 20)
    assert_equal(20000, @d02.priority(today))
  end

  def test_event_dates
    results = @d00.event_dates
    assert_equal(2                     , results.size)
    assert_equal(Date.new(2012, 10,  5), results[0]  )
    assert_equal(Date.new(2012, 10, 15), results[1]  )
    assert_equal(Date                  , results[0].class  )
    assert_equal(Date                  , results[1].class  )

    results = @d01.event_dates
    assert_equal(2                     , results.size)
    assert_equal(Date.new(2012, 10,  5), results[0]  )
    assert_equal(Date.new(2012, 10, 15), results[1]  )
    assert_equal(Date                  , results[0].class  )
    assert_equal(Date                  , results[1].class  )
  end

end
