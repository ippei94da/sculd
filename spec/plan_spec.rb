require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan do # E.g., Klass
  context 'Class method' do # 'when stack is empty'
    describe '#parse' do # ''
      context '[2012-10-23]! deadlineA' do
        it 'should return Date, !, deadlineA' do
          a, b, c = Sculd::Plan.parse('[2012-10-23]! deadlineA')
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == ""
        end
      end

      context '  [2012-10-23]! deadlineA with space at head' do
        it 'should return Date, !, deadlineA' do
          a, b, c = Sculd::Plan.parse('  [2012-10-23]! deadlineA with space at head')
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == ""
        end
      end

      context '[2012-10-23]!10 deadline with option value' do
        it 'should return Date, !, deadlineA' do
          a, b, c = Sculd::Plan.parse( '[2012-10-23]!10 deadline with option value')
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == "10"
        end
      end

    end
  end
end

