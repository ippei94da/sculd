require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan::Todo do # E.g., Klass
  context 'Date[2012-10-15], 10, [2012-10-15]+10 todoA' do

    before do
      today = Date.new(2012, 10, 15)
      @t00 = Sculd::Plan::Todo.new(today, 10, '[2012-10-15]+10 todoA')
    end

    describe '#priority' do # ''
      context '' do

        it 'return 0 before the period.' do
          today = Date.new(2012, 10,  1)
          @t00.priority(today).should == 0
        end

        it 'return REMINDER_PRIORITY when the day is today.' do
          today = Date.new(2012, 10, 15)
          @t00.priority(today).should == 10000
        end

        it 'return values between REMINDER_PRIORITY and DEADLINE_PRIORITY during the period.' do
          today = Date.new(2012, 10, 20)
          @t00.priority(today).should == 15000
        end

        it 'return DEADLINE_PRIORITY when the day is past.' do
          today = Date.new(2012, 10, 30)
          @t00.priority(today).should == 20000
        end

      end
    end

    describe "#events" do
      context '' do
        it '' do
          @t00.events.size.should == 2
          @t00.events[0].date.should == Date.new(2012, 10, 15)
          @t00.events[1].date.should == Date.new(2012, 10, 25)
        end
      end
    end
  end
end

