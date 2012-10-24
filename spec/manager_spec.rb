require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Sculd::Manager
  public :load_file, :show_events
  attr_accessor :plans
end

describe "Manager" do
  context "empty" do
    before do
      @s00 = Sculd::Manager.new("spec/schedule/empty.dat")
    end

    describe "#load_file" do
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
  end
  
  context "when there are some plans" do
    before do
      @s01 = Sculd::Manager.new("spec/schedule/schedule.dat")
    end

    describe "#show_events" do
      it 'should return itemized days and events' do
        io = StringIO.new
        today = Date.new(2012, 9,6)
        @s01.show_events(10, today, io)
        io.rewind
        results = io.readlines
        results.size.should == 5
        results[].should == 'Events:'
        results[].should == '  [2012-09-06]'
        results[].should == '    [2012-09-16]! deadline b'
        results[].should == ''
        results[].should == '  [2012-09-15]'
        results[].should == '    [2012-09-15]@ schedule a'
        #results[].should == ''
        #results[].should == '  [2012-09-16]'
        #results[].should == '    [2012-09-16]! deadline b'
        #results[].should == ''
        #results[].should == '  [2012-09-17]'
        #results[].should == '    [2012-09-17]- reminder c'
        #results[].should == ''
        #results[].should == '  [2012-09-18]'
        #results[].should == '    [2012-09-18]+ todo d'
        #results[].should == ''
        #results[].should == '  [2012-09-15]'
        #results[].should == '    [2012-09-18]+ todo d'
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
