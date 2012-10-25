require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Plan::Schedule do # E.g., Klass
  context 'normal' do # 'when stack is empty'
    before do
      date = Date.new(2012, 10, 15)
      @s00 = Sculd::Plan::Schedule.new(date, 0, "[2012-10-15]@ scheduleA")
    end

    describe '#priority' do # ''
      context '' do
        it 'should return 0' do
          @s00.priority.should == 0
        end
      end
    end

    describe '#events' do # ''
      context '' do
        it 'should return Array of 1 item' do
          @s00.events.class == Array
          @s00.events.size == 1
          @s00.events[0].date == Date.new(2012, 10, 15)
        end
      end
    end

  end
end

