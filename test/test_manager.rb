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
    result = @s00.load_file("test/schedule/normal/a.dat")
    assert_equal(4, @s00.plans.size)
    assert(@s00.plans[0].is_a? Sculd::Plan)
    assert(@s00.plans[1].is_a? Sculd::Plan)
    assert(@s00.plans[2].is_a? Sculd::Plan)
    assert(@s00.plans[3].is_a? Sculd::Plan)

    result = @s00.load_file("test/schedule/empty/empty.dat")
    assert_equal(4, @s00.plans.size)

    #context "data containing error" do it "should interrupt with error line." do
    io = StringIO.new
    assert_raise(Sculd::Manager::LoadError){ @s00.load_file("test/schedule/error/error.dat", io)}
  end

  def test_days_events
    #it 'should return hash dates as keys and events as values.' do
    results = @s01.days_events
    assert_equal(
      [
        Date.new(2012, 9, 15), #@ schedule a 2012, 09, 06),
        Date.new(2012, 9,  9), #! deadline b 2012, 09, 06),
        Date.new(2012, 9, 16), #! deadline b 2012, 09, 06),
        Date.new(2012, 9, 17), #- reminder c 2012, 09, 06),
        Date.new(2012, 9, 18), #+ todo d     2012, 09, 06),
        Date.new(2012, 9, 25), #+ todo d     2012, 09, 06),
        Date.new(2012,10, 15), #@ schedule a 2012, 09, 06),
        Date.new(2012,10,  9), #! deadline b 2012, 09, 06),
        Date.new(2012,10, 16), #! deadline b 2012, 09, 06),
        Date.new(2012,10, 17), #- reminder c 2012, 09, 06),
        Date.new(2012,10, 18), #+ todo d     2012, 09, 06),
        Date.new(2012,10, 25), #+ todo d     2012, 09, 06),
      ],
      results.keys
    )
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
    assert_equal(7, results.size)
    assert_equal("Events:\n"                            , results[0])
    assert_equal("  [37m[44m 2012-09-15 Sat [0m\n", results[1])
    assert_equal("    [2012-09-15]@ schedule a\n"       , results[2])
    assert_equal("\n"                                   , results[3])
    assert_equal("  [37m[41m 2012-09-16 Sun [0m\n", results[4])
    assert_equal("    [2012-09-16]! deadline b\n"       , results[5])
    assert_equal("\n"                                   , results[6])
  end

  def test_show_tasks
    #it 'should return sorted tasks' do
    io = StringIO.new
    today = Date.new(2012, 9,20)
    @s01.show_tasks(3, today, io)
    io.rewind
    results = io.readlines
    assert_equal(4, results.size)
    assert_equal("Tasks:\n"                    , results[0])
    assert_equal("  [2012-09-16]! deadline b\n", results[1])
    assert_equal("  [2012-09-18]+ todo d\n"    , results[2])
    assert_equal("  [2012-09-17]- reminder c\n", results[3])
  end
end
