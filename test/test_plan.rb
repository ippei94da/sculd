#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Plan < Test::Unit::TestCase
  def test_parse
    ## correct string
    a, b, c = Sculd::Plan.parse('[2012-10-23]! deadlineA')
    assert_equal(DateTime.new(2012, 10, 23, 0, 0, 0) , a)
    assert_equal("!"                                 , b)
    assert_equal(""                                  , c)

    a, b, c = Sculd::Plan.parse('[2012-10-23 01:02:03]@ deadlineA')
    assert_equal(DateTime.new(2012, 10, 23, 1, 2, 3) , a)
    assert_equal("@"                                 , b)
    assert_equal(""                                  , c)

    a, b, c = Sculd::Plan.parse('[2012-11-01 01:02:03(Thu)]@ deadlineA')
    assert_equal(DateTime.new(2012, 11, 01, 1, 2, 3) , a)
    assert_equal("@"                                 , b)
    assert_equal(""                                  , c)

    a, b, c = Sculd::Plan.parse('[2012-11-01 01:02:03(th)]@ deadlineA')
    assert_equal(DateTime.new(2012, 11, 01, 1, 2, 3) , a)
    assert_equal("@"                                 , b)
    assert_equal(""                                  , c)

    #context 'schedule with wrong weekday' do
    io = StringIO.new
    assert_raise(Sculd::Plan::WeekdayMismatchError ){ Sculd::Plan.parse('[2012-11-01 01:02:03(Sun)]@ deadlineA', io)}
    assert_raise(Sculd::Plan::NotWeekdayError      ){ Sculd::Plan.parse('[2012-11-01 01:02:03(abc)]@ deadlineA', io)}

    #Unable to interpret as date in [].
    #assert_raise(Sculd::Plan::NotDateError ){ Sculd::Plan.parse('[abc]! deadlineA')}
    assert_raise(ArgumentError){ Sculd::Plan.parse('[abc]! deadlineA')}

    ##Illegal syntax
    # '[abc]]! deadlineA' do
    a, b, c = Sculd::Plan.parse('[2012-01-01]]! deadlineA')
    assert_equal(DateTime.new(2012, 01, 01) , a)
    assert_equal("]"                        , b)
    assert_equal("!"                        , c)

    #context '  [2012-10-23]! deadlineA with space at head' do
    #it 'should return Date, !, deadlineA' do
    a, b, c = Sculd::Plan.parse('  [2012-10-23]! deadlineA with space at head')
    assert_equal(Date.new(2012, 10, 23) , a)
    assert_equal("!"                    , b)
    assert_equal(""                     , c)

    #context '[2012-10-23]!10 deadline with option value' do
    #it 'should return Date, !, deadlineA' do
    a, b, c = Sculd::Plan.parse( '[2012-10-23]!10 deadline with option value')
    assert_equal(Date.new(2012, 10, 23) , a)
    assert_equal("!"                    , b)
    assert_equal("10"                   , c)
  end
end
