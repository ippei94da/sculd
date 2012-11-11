require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
# coding: utf-8

#require "stringio"

class Sculd::Manager
  public :load_file, :show_events, :days_events, :show_tasks
  attr_accessor :plans
end

describe "Manager" do
  context "empty" do
    before do
      @s00 = Sculd::Manager.new("spec/schedule/empty.dat")
    end

    describe "#load_file" do
      context "correct data" do
        it "should overwrite data" do
          result = @s00.load_file("spec/schedule/schedule.dat")
          @s00.plans.size.should == 4
          @s00.plans[0].should be_kind_of Sculd::Plan
          @s00.plans[1].should be_kind_of Sculd::Plan
          @s00.plans[2].should be_kind_of Sculd::Plan
          @s00.plans[3].should be_kind_of Sculd::Plan

          result = @s00.load_file("spec/schedule/empty.dat")
          @s00.plans.size.should == 0
        end
      end

      context "data containing error" do
        it "should interrupt with error line." do
          io = StringIO.new
          lambda{ @s00.load_file("spec/schedule/error.dat", io)}.should raise_error Sculd::Manager::LoadError
        end
      end
    end
  end
  
  context "when there are some plans" do
    before do
      @s01 = Sculd::Manager.new("spec/schedule/schedule.dat")
    end

    describe "#days_events" do
      it 'should return hash dates as keys and events as values.' do
        results = @s01.days_events
        results.keys.should == [
          Date.new(2012, 9, 15), #@ schedule a 2012, 09, 06),
          Date.new(2012, 9,  9), #! deadline b 2012, 09, 06),
          Date.new(2012, 9, 16), #! deadline b 2012, 09, 06),
          Date.new(2012, 9, 17), #- reminder c 2012, 09, 06),
          Date.new(2012, 9, 18), #+ todo d     2012, 09, 06),
          Date.new(2012, 9, 25), #+ todo d     2012, 09, 06),
        ]
        results[Date.new(2012, 9, 15)].should be_kind_of Array
        #pp results[Date.new(2012, 9, 15)][0]
        results[Date.new(2012, 9, 15)][0].should be_kind_of Sculd::Event
      end
    end

    describe "#show_events" do
      it 'should return itemized days and events' do
        io = StringIO.new
        today = Date.new(2012, 9,6)
        @s01.show_events(10, today, io)
        io.rewind
        results = io.readlines
        #pp results
        results.size.should == 7
        results[0].should == "Events:\n"
        #results[1].should == "  2012-09-09 Sun\n"
        results[1].should == "  [37m[41m2012-09-09 Sun[0m\n"
        results[2].should == "    [2012-09-16]! deadline b\n"
        results[3].should == "\n"
        $results[4].should == "  2012-09-15 Sat\n"
        results[4].should == "  [37m[44m2012-09-15 Sat[0m\n"
        results[5].should == "    [2012-09-15]@ schedule a\n"
        results[6].should == "\n"
        #results[].should == "\n"
        #results[].should == "  [2012-09-16]\n"
        #results[].should == "    [2012-09-16]! deadline b\n"
        #results[].should == "\n"
        #results[].should == "  [2012-09-17]\n"
        #results[].should == "    [2012-09-17]- reminder c\n"
        #results[].should == "\n"
        #results[].should == "  [2012-09-18]\n"
        #results[].should == "    [2012-09-18]+ todo d\n"
        #results[].should == "\n"
        #results[].should == "  [2012-09-15]\n"
        #results[].should == "    [2012-09-18]+ todo d\n"
      end
    end

    describe "#show_tasks" do
      it 'should return sorted tasks' do
        io = StringIO.new
        today = Date.new(2012, 9,20)
        @s01.show_tasks(3, today, io)
        io.rewind
        results = io.readlines
        #pp results
        results.size.should == 4
        results[0].should == "Tasks:\n"
        results[1].should == "  [2012-09-16]! deadline b\n"
        results[2].should == "  [2012-09-18]+ todo d\n"
        results[3].should == "  [2012-09-17]- reminder c\n"
        #results[4].should == "  [2012-09-15]@ schedule a\n"
      end
    end
  end
end

#describe "Manager" do
#  context "empty" do
#    describe "#load_file" do
#      result = @s00.load_file("spec/schedule/schedule.dat")
#      it '' do
#        @s00.plans.size.should == 4
#        @s00.plans[0].should be_kind_of Sculd::Plan
#        @s00.plans[1].should be_kind_of Sculd::Plan
#        @s00.plans[2].should be_kind_of Sculd::Plan
#        @s00.plans[3].should be_kind_of Sculd::Plan
#
#        result = @s00.load_file("spec/schedule/empty.dat")
#        @s00.plans.size.should == 0
#      end
#    end
#  end
#end
#
