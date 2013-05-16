#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Plan < Test::Unit::TestCase
  def test_parse
    ## correct string
    result = Sculd::Plan.parse('[2012-10-23]! deadlineA')
    date = DateTime.new(2012, 10, 23, 0, 0, 0)
    assert_equal(date       , result[:datetime])
    assert_equal("!"        , result[:type])
    assert_equal(nil        , result[:option])
    assert_equal("deadlineA", result[:description])

    result = Sculd::Plan.parse('[2012-10-23]!30 deadlineA')
    date = DateTime.new(2012, 10, 23, 0, 0, 0)
    assert_equal(date       , result[:datetime])
    assert_equal("!"        , result[:type])
    assert_equal(30         , result[:option])
    assert_equal("deadlineA", result[:description])

    result = Sculd::Plan.parse('[2012-10-23 01:02:03]@ scheduleA')
    date = DateTime.new(2012, 10, 23, 1, 2, 3)
    assert_equal(date       , result[:datetime])
    assert_equal("@"        , result[:type])
    assert_equal(nil        , result[:option])
    assert_equal("scheduleA", result[:description])

    result = Sculd::Plan.parse('[2012-11-01 01:02:03(Thu)]@ scheduleA')
    date = DateTime.new(2012, 11,  1, 1, 2, 3)
    assert_equal(date       , result[:datetime])
    assert_equal("@"        , result[:type])
    assert_equal(nil        , result[:option])
    assert_equal("scheduleA", result[:description])

    result = Sculd::Plan.parse('[2012-11-01 01:02:03(th)]@ scheduleA')
    date = DateTime.new(2012, 11, 01, 1, 2, 3)
    assert_equal(date       , result[:datetime])
    assert_equal("@"        , result[:type])
    assert_equal(nil        , result[:option])
    assert_equal("scheduleA", result[:description])

    #context 'schedule with wrong weekday' do
    io = StringIO.new
    assert_raise(Sculd::Plan::WeekdayMismatchError ){ Sculd::Plan.parse('[2012-11-01 01:02:03(Sun)]@ scheduleA', io)}
    assert_raise(Sculd::Plan::NotWeekdayError      ){ Sculd::Plan.parse('[2012-11-01 01:02:03(abc)]@ scheduleA', io)}

    #Unable to interpret as date in [].
    #assert_raise(Sculd::Plan::NotDateError ){ Sculd::Plan.parse('[abc]! deadlineA')}
    assert_raise(ArgumentError){ Sculd::Plan.parse('[abc]! deadlineA')}

    ##Illegal syntax
    # '[abc]]! deadlineA' do
    assert_raise(Sculd::Plan::NotNumberError){ 
      Sculd::Plan.parse('[2012-01-01]]! deadlineA')
    }
    #date = DateTime.new(2012, 01, 01)
    #assert_equal(date       , result[:datetime])
    #assert_equal("]"        , result[:type])
    #assert_equal("!"        , result[:option])
    #assert_equal("deadlineA", result[:description])

    #context '  [2012-10-23]! deadlineA with space at head' do
    #it 'should return Date, !, deadlineA' do
    result = Sculd::Plan.parse('  [2012-10-23]! deadlineA with space at head')
    date = DateTime.new(2012, 10, 23)
    assert_equal(date       , result[:datetime])
    assert_equal("!"        , result[:type])
    assert_equal(nil        , result[:option])
    assert_equal("deadlineA with space at head", result[:description])

    #context '[2012-10-23]!10 deadline with option value' do
    #it 'should return Date, !, deadlineA' do
    result = Sculd::Plan.parse( '[2012-10-23]!10 deadline with option value')
    date = DateTime.new(2012, 10, 23)
    assert_equal(date       , result[:datetime])
    assert_equal("!"        , result[:type])
    assert_equal(10         , result[:option])
    assert_equal("deadline with option value", result[:description])
  end
end
