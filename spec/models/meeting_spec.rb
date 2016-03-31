require 'rails_helper'

describe Meeting do
  let(:subject) { build(:meeting) }
  let(:earliest_start) { Tod::TimeOfDay.new(9, 0, 0) }
  let(:latest_start)   { Tod::TimeOfDay.new(21, 0, 0) }

  describe '.time_of_day' do
    it 'references Tod::TimeOfDay' do
      actual = described_class.send(:time_of_day)
      expect(actual).to eq Tod::TimeOfDay
    end
  end

  describe '.earliest_start' do
    context 'when @earliest_start is already set' do
      let(:time_of_day) { double('TimeOfDay') }

      before(:each) do
        described_class.instance_eval { @earliest_start = 'foo' }
        allow(described_class).to receive(:time_of_day).and_return(time_of_day)
      end
      after(:each) do
        described_class.instance_eval { @earliest_start = nil }
      end

      it 'does not call for new TimeOfDay object' do
        expect(time_of_day).not_to receive(:new)
        described_class.send(:earliest_start)
      end

      it 'returns value of @earliest_start' do
        actual = described_class.send(:earliest_start)
        expect(actual).to eq 'foo'
      end
    end

    context 'when @earliest_start is not set' do
      before(:each) do
      end

      it 'calls for new instance of Tod::TimeOfDay' do
      end
    end
  end
end
