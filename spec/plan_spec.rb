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
          c.should == "deadlineA"
        end
      end
    end
  end
end

