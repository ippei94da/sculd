require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Plan do # E.g., Klass
  context 'Class method' do # 'when stack is empty'
    describe '#parse' do # ''
      str = '[2012-10-23]! deadlineA'
      context str do
        it 'should return Date, !, deadlineA' do
          a, b, c = Plan.parse(str)
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == ""
        end
      end

      str = '  [2012-10-23]! deadlineA with space at head'
      context str do
        it 'should return Date, !, deadlineA' do
          a, b, c = Plan.parse(str)
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == ""
        end
      end

      str = '[2012-10-23]!10 deadline with option value'
      context str do
        it 'should return Date, !, deadlineA' do
          a, b, c = Plan.parse(str)
          a.should == Date.new(2012, 10, 23)
          b.should == "!"
          c.should == "10"
        end
      end

      #str = '  [2012-10-23]% deadlineA'
      #context str do
      #  it 'should raise' do
      #    TODO
      #  end
      #end
    end
  end
end

