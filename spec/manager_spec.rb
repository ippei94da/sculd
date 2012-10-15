require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Sculd::Manager
  public load_file
end

describe "Manager" do
  before do
    
  end

  it "#load" do
    results = Sculd::Manager.load_file("spec/schedule.dat")
  end
end
