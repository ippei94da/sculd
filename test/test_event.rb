#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Event < Test::Unit::TestCase
  def setup
    datetime = DateTime.new(2012, 3, 4, 5, 6, 7)
    @e00 = Sculd::Event.new(datetime, "abc")
  end

  def test_date
    assert_equal(Date.new(2012, 3, 4), @e00.date)
  end

  def test_datetime
    assert_equal(DateTime.new(2012, 3, 4, 5, 6, 7), @e00.datetime)
  end

  def test_description
    assert_equal("abc", @e00.description)
  end
end
