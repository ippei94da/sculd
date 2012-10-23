require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan::Reminder do # E.g., Klass
  context 'Date[2012-10-23], 10, [2012-10-23]- reminderA' do

    before do
      date = Date.new(2012, 10, 23)
      @r00 = Sculd::Plan::Reminder.new(date, 10, '[2012-10-23]- reminderA')
    end

    describe '#priority' do # ''
      context '' do
        it 'return REMINDER_PRIORITY when the day is today .' do
          date = Date.new(2012, 10, 23)
          @r00.priority(date).should == 10000
        end

        it 'return REMINDER_PRIORITY -1 when the day is yesterday .' do
          date = Date.new(2012, 10, 24)
          @r00.priority(date).should == 9999
        end
      end
    end

    describe '#events' do # ''
      context '' do
        it 'return a Sculd::Event instance.' do
          result = @r00.events
          result.class.should == Array
          result.size.should == 1
          result[0].class.should == Sculd::Event
          result[0].datetime.to_date.should == Date.new(2012, 10, 23)
        end
      end
    end
  end
end

