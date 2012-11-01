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

      context '[2012-10-23 01:02:03]@ deadlineA' do
        it 'should return Date, @, ""' do
          a, b, c = Sculd::Plan.parse('[2012-10-23 01:02:03]@ deadlineA')
          a.should == DateTime.new(2012, 10, 23, 1, 2, 3)
          b.should == "@"
          c.should == ""
        end
      end

      context 'schedule with correct weekday' do
        it 'should return Date, @, ""' do
          a, b, c = Sculd::Plan.parse('[2012-11-01 01:02:03(Thu)]@ deadlineA')
          a.should == DateTime.new(2012, 11, 01, 1, 2, 3)
          b.should == "@"
          c.should == ""

          a, b, c = Sculd::Plan.parse('[2012-11-01 01:02:03(th)]@ deadlineA')
          a.should == DateTime.new(2012, 11, 01, 1, 2, 3)
          b.should == "@"
          c.should == ""
        end
      end

      context 'schedule with wrong weekday' do
        it 'should return Date, @, ""' do
          io = StringIO.new
          lambda{ Sculd::Plan.parse('[2012-11-01 01:02:03(Sun)]@ deadlineA', io)}.should raise_error Sculd::Plan::WeekdayMismatchError

          lambda{ Sculd::Plan.parse('[2012-11-01 01:02:03(abc)]@ deadlineA', io)}.should raise_error Sculd::Plan::NotWeekdayError
        end
      end

      context '[abc]! deadlineA' do
        it 'should raise exception' do
          #Sculd::Plan.parse('[abc]! deadlineA')
          #fail
          lambda{ Sculd::Plan.parse('[abc]! deadlineA')}.should raise_error
        end
      end

      context '[abc]]! deadlineA' do
        it 'should raise exception' do
          a, b, c = Sculd::Plan.parse('[2012-01-01]]! deadlineA')
          a.should == DateTime.new(2012, 01, 01)
          b.should == "]"
          c.should == "!"
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

