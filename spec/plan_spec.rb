require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan do # E.g., Klass
  context 'Class method' do # 'when stack is empty'
    describe '#parse' do # ''
      context '[2012-10-23]! deadlineA' do
        it 'should return Date, !, ""' do
          a, b, c = Sculd::Plan.parse('[2012-10-23]! deadlineA')
          a.should == DateTime.new(2012, 10, 23, 0, 0, 0)
          b.should == "!"
          c.should == ""
        end
      end

      context '[2012-10-23 01:02:03]! deadlineA' do
        it 'should return Date, !, ""' do
          a, b, c = Sculd::Plan.parse('[2012-10-23 01:02:03]! deadlineA')
          a.should == DateTime.new(2012, 10, 23, 1, 2, 3)
          b.should == "!"
          c.should == ""
        end
      end

      context '[abc]! deadlineA' do
        it 'should raise exception' do
          lambda{ Sculd::Plan.parse('[abc]! deadlineA')}.should raise_error
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

