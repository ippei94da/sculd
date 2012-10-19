require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Sculd::Manager
  public :load_file
  attr_accessor :plans
end

describe "Manager" do
  before do
    @s00 = Sculd::Manager.new("spec/schedule/empty.dat")
  end

  it "#load_file" do
    result = @s00.load_file("spec/schedule/schedule.dat")
    @s00.plans.size.should == 4
    @s00.plans[0].class.should be_a Sculd::Plan
    @s00.plans[1].class.should be_a Sculd::Plan
    @s00.plans[2].class.should be_a Sculd::Plan
    @s00.plans[3].class.should be_a Sculd::Plan

    result = @s00.load_file("spec/schedule/empty.dat")
    @s00.plans.size.should == 0
  end
end
