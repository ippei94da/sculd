#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class Sculd::Manager
  public :load_file, :show_events, :days_events, :show_tasks
  attr_accessor :plans
end

class TC_Manager < Test::Unit::TestCase
  def setup
    @s00 = Sculd::Manager.new("test/schedule/empty")
    @s01 = Sculd::Manager.new("test/schedule/normal")
  end

  def test_load_file
    #context "correct data" do #it "should overwrite data" do
    @s00.load_file("test/schedule/normal/a.dat")
    assert_equal(8, @s00.plans.size)
    plans = @s00.plans
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
    assert(plans.shift.is_a? Sculd::Plan)
  end

  def test_load_file_empty
    @s00.load_file("test/schedule/empty/empty.dat")
    assert_equal(0, @s00.plans.size)

    #context "data containing error" do it "should interrupt with error line." do
    io = StringIO.new
    assert_raise(Sculd::Manager::LoadError){ @s00.load_file("test/schedule/error/error.dat", io)}
  end

  def test_days_events
    #it 'should return hash dates as keys and events as values.' do
    results = @s01.days_events
    keys = results.keys
    #pp results

    ## normal/a.dat
    assert_equal(Date.new(2012, 9, 15), keys.shift)
    assert_equal(Date.new(2012, 9,  9), keys.shift)
    assert_equal(Date.new(2012, 9, 16), keys.shift)
    assert_equal(Date.new(2012, 9, 17), keys.shift)
    assert_equal(Date.new(2012, 9, 18), keys.shift)
    assert_equal(Date.new(2012, 9, 25), keys.shift)
    assert_equal(Date.new(2012, 8, 17), keys.shift)
    assert_equal(Date.new(2012, 9, 28), keys.shift)
    ## normal/b.dat
    assert_equal(Date.new(2012,10, 15), keys.shift)
    assert_equal(Date.new(2012,10,  9), keys.shift)
    assert_equal(Date.new(2012,10, 16), keys.shift)
    assert_equal(Date.new(2012,10, 17), keys.shift)
    assert_equal(Date.new(2012,10, 18), keys.shift)
    assert_equal(Date.new(2012,10, 25), keys.shift)
    assert_equal(nil                  , keys.shift)

    assert(results[Date.new(2012, 9, 15)].is_a? Array)
    assert(results[Date.new(2012, 9, 15)][0].is_a? Sculd::Event)
  end

  def test_show_events
    #it 'should return itemized days and events' do
    io = StringIO.new
    today = Date.new(2012, 9, 15)
    @s01.show_events(2, today, io)
    io.rewind
    results = io.readlines
    #pp results
    #assert_equal(9, results.size)
    assert_equal("Events:\n"                    , results.shift)
    assert_equal("  [37m[44m 2012-09-15 Sat [0m\n",
                 results.shift)
    assert_equal("           @   schedule a\n"  , results.shift)
    assert_equal("    [23:45]@   schedule a'\n" , results.shift)
    assert_equal("\n"                           , results.shift)
    assert_equal("  [37m[41m 2012-09-16 Sun [0m\n",
                 results.shift)
    assert_equal("           !   deadline b\n"  , results.shift)
    assert_equal("    [23:45]!30 deadline b\n"  , results.shift)
    assert_equal("\n"                           , results.shift)
    assert_equal(nil                            , results.shift)
  end

  def test_show_tasks
    #it 'should return sorted tasks' do
    io = StringIO.new
    today = Date.new(2012, 9,20)
    @s01.show_tasks(6, today, io)
    io.rewind
    results = io.readlines
    #pp results
    #assert_equal(7, results.size)
    assert_equal("Tasks:\n"                       , results.shift)
    assert_equal("  [2012-09-16]!   deadline b\n" , results.shift)
    assert_equal("  [2012-09-18]+   todo     d\n" , results.shift)
    assert_equal("  [2012-09-17]-   reminder c\n" , results.shift)
    assert_equal("  [2012-09-16]!30 deadline b'\n", results.shift)
    assert_equal("  [2012-09-18]+   todo     d'\n", results.shift)
    assert_equal("  [2012-09-17]-   reminder c'\n", results.shift)
    assert_equal(nil                              , results.shift)
  end
end
