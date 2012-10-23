require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan::Deadline do # E.g., Klass
  context 'Date[2012-10-15], 10, [2012-10-15]!10 deadlineA' do

    before do
      today = Date.new(2012, 10, 15)
      @d00 = Sculd::Plan::Deadline.new(today, 10, '[2012-10-15]!10 deadlineA')
    end

    describe '#priority' do # ''
      context '' do
        it 'return DEADLINE_PRIORITY when the day is today.' do
          today = Date.new(2012, 10, 15)
          @d00.priority(today).should == 20000
        end

        it 'return DEADLINE_PRIORITY when the day is past.' do
          today = Date.new(2012, 10, 20)
          @d00.priority(today).should == 20000
        end

        it 'return values between REMINDER_PRIORITY and DEADLINE_PRIORITY during the period.' do
          today = Date.new(2012, 10, 10)
          @d00.priority(today).should == 15000
        end

        it 'return nil before the period.' do
          today = Date.new(2012, 10,  1)
          @d00.priority(today).should == nil
        end
      end
    end

    describe "#events" do
      context '' do
        it '' do
          @d00.events.size.should == 2
          @d00.events[0].date.should == Date.new(2012, 10,  5)
          @d00.events[1].date.should == Date.new(2012, 10, 15)
        end
      end
    end
  end
end

