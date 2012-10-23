require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sculd::Event do # E.g., Klass
  context 'normal' do # 'when stack is empty'
    before do
      datetime = DateTime.new(2012, 3, 4, 5, 6, 7)
      @e00 = Sculd::Event.new(datetime, "abc")
    end

    describe '#date' do # ''
      context '' do
        it 'should return Date.new(2012, 3, 4)' do
          @e00.date.should == Date.new(2012, 3, 4)
        end
      end
    end

    describe '#datetime' do # ''
      context '' do
        it 'should return DateTime.new(2012, 3, 4, 5, 6, 7)' do
          @e00.datetime.should == DateTime.new(2012, 3, 4, 5, 6, 7)
        end
      end
    end

    describe '#description' do # ''
      context '' do
        it 'should return abc' do
          @e00.description.should == "abc"
        end
      end
    end
  end
end

