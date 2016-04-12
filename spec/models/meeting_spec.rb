require 'rails_helper'

describe Meeting do
  subject { build(:meeting) }
  let(:earliest_start) { Tod::TimeOfDay.new(9, 0, 0) }
  let(:latest_start)   { Tod::TimeOfDay.new(21, 0, 0) }
  let(:enrollment) { build(:enrollment) }

  describe '.lessons_for_person' do
    before(:each) do
      allow(described_class).to receive(:collection_for_person)
    end

    it 'calls .collection_for_person' do
      expect(described_class).to receive(:collection_for_person).with(1)
      described_class.lessons_for_person(1)
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
      after(:each) do
        described_class.instance_eval { @earliest_start = nil }
      end

      it 'calls for new instance of Tod::TimeOfDay' do
        actual = described_class.earliest_start
        expect(actual).to be_an_instance_of Tod::TimeOfDay
      end
      it 'caches that value in an ivar' do
        described_class.earliest_start
        actual = described_class.instance_eval { @earliest_start }
        expect(actual).not_to be_nil
      end
    end
  end

  describe '.latest_start' do
    context 'when @latest_start is already set' do
      let(:time_of_day) { double('TimeOfDay') }

      before(:each) do
        described_class.instance_eval { @latest_start = 'foo' }
        allow(described_class).to receive(:time_of_day).and_return(time_of_day)
      end
      after(:each) do
        described_class.instance_eval { @latest_start = nil }
      end

      it 'does not call for new TimeOfDay object' do
        expect(time_of_day).not_to receive(:new)
        described_class.send(:latest_start)
      end

      it 'returns value of @latest_start' do
        actual = described_class.send(:latest_start)
        expect(actual).to eq 'foo'
      end
    end

    context 'when @latest_start is not set' do
      after(:each) do
        described_class.instance_eval { @latest_start = nil }
      end

      it 'calls for new instance of Tod::TimeOfDay' do
        actual = described_class.latest_start
        expect(actual).to be_an_instance_of Tod::TimeOfDay
      end
      it 'caches that value in an ivar' do
        described_class.latest_start
        actual = described_class.instance_eval { @latest_start }
        expect(actual).not_to be_nil
      end
    end
  end

  describe '._collection_for_person' do
    let(:relation) { double('relation') }

    before(:each) do
      allow(described_class)
        .to receive(:teacher_id_or_student_id_matches)
        .and_return(:foo)
      allow(described_class).to receive(:joins).and_return(relation)
      allow(relation).to receive(:where).and_return(relation)
      allow(relation).to receive(:distinct)
    end
    after(:each) do
      described_class.send(:_collection_for_person, 1)
    end

    it 'calls .teacher_id_or_student_id_matches' do
      expect(described_class)
        .to receive(:teacher_id_or_student_id_matches)
        .with(1)
    end
    it 'calls .joins' do
      expect(described_class).to receive(:joins).with(:enrollment)
    end
    it 'calls .where' do
      expect(relation).to receive(:where).with(:foo)
    end
    it 'calls .distinct' do
      expect(relation).to receive(:distinct)
    end
  end

  describe '.time_of_day' do
    it 'references Tod::TimeOfDay' do
      actual = described_class.send(:time_of_day)
      expect(actual).to eq Tod::TimeOfDay
    end
  end

  describe '#overlaps?' do
    let(:actual) { subject.overlaps?(lower_bound, upper_bound) }

    before(:each) do
      allow(subject).to receive(:start).and_return(10)
      allow(subject).to receive(:stop).and_return(20)
    end

    context 'both lower & upper bounds are < range min' do
      let(:lower_bound) { 1 }
      let(:upper_bound) { 9 }

      it 'returns false' do
        expect(actual).to be_falsey
      end
    end
    context 'lower bound not in range, upper bound is in range' do
      let(:lower_bound) { 9 }
      let(:upper_bound) { 10 }

      it 'returns true' do
        expect(actual).to be_truthy
      end
    end
    context 'both lower & upper bounds are in range' do
      let(:lower_bound) { 10 }
      let(:upper_bound) { 20 }

      it 'returns true' do
        expect(actual).to be_truthy
      end
    end
    context 'lower bound in range, upper bound out of range' do
      let(:lower_bound) { 20 }
      let(:upper_bound) { 21 }

      it 'returns true' do
        expect(actual).to be_truthy
      end
    end
    context 'both lower & upper bounds are > range max' do
      let(:lower_bound) { 21 }
      let(:upper_bound) { 22 }

      it 'returns false' do
        expect(actual).to be_falsey
      end
    end
  end

  describe '#stop' do
    context 'when #start is nil' do
      before(:each) do
        allow(subject).to receive(:start?).and_return(false)
      end

      it 'returns nil' do
        expect(subject.stop).to be_nil
      end
    end

    context 'when #length is nil' do
      before(:each) do
        allow(subject).to receive(:start?).and_return(true)
        allow(subject).to receive(:length?).and_return(false)
      end

      it 'returns nil' do
        expect(subject.stop).to be_nil
      end
    end

    context 'otherwise' do
      let(:start) { Time.new(2016, 1, 1, 12, 0, 0) }

      before(:each) do
        allow(subject).to receive(:start?).and_return(true)
        allow(subject).to receive(:length?).and_return(true)
        allow(subject).to receive(:start).and_return(start)
        allow(subject).to receive(:length_to_i).and_return(45)
      end

      it 'returns "length" minutes after start' do
        expected = Time.new(2016, 1, 1, 12, 45, 0)
        expect(subject.stop).to eq expected
      end
    end
  end

  describe '#length_to_i' do
    before(:each) do
      allow(subject).to receive(:length).and_return('thirty_minute')
    end

    it 'returns the integer equivalent of "length"' do
      expect(subject.length_to_i).to eq 30
    end
  end

  describe '#round_start_down' do
    context 'when start is nil' do
      before(:each) do
        allow(subject).to receive(:start?).and_return(false)
      end

      it 'returns nil' do
        actual = subject.send(:round_start_down)
        expect(actual).to be_nil
      end
    end

    context 'otherwise' do
      let(:start) { Time.new(2016, 1, 1, 12, 37, 0) }
      let(:rounded_start) { Time.new(2016, 1, 1, 12, 30, 0) }

      before(:each) do
        subject.start = start
        allow(subject).to receive(:round_minute_down).and_return(30)
      end

      it 'rounds the minute down' do
        expect { subject.send(:round_start_down) }
          .to change { subject.start }
          .from(start).to(rounded_start)
      end
    end
  end

  describe '#round_minute_down' do
    minute_interval = 10

    before(:each) do
      allow(subject).to receive(:minute_interval).and_return(minute_interval)
    end

    it "rounds a number down to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_down, 11)
      expect(actual).to eq 10
    end
    it "rounds a number down to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_down, 10)
      expect(actual).to eq 10
    end
    it "rounds a number down to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_down, 9)
      expect(actual).to eq 0
    end
  end

  describe '#round_minute_up' do
    minute_interval = 10

    before(:each) do
      allow(subject).to receive(:minute_interval).and_return(minute_interval)
    end

    it "rounds a number up to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_up, 11)
      expect(actual).to eq 20
    end
    it "rounds a number up to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_up, 10)
      expect(actual).to eq 10
    end
    it "rounds a number up to the nearest multiple of #{minute_interval}" do
      actual = subject.send(:round_minute_up, 9)
      expect(actual).to eq 10
    end
  end

  describe '#minute_interval' do
    it 'references the constant' do
      expected = described_class::MINUTE_INTERVAL
      expect(subject.send(:minute_interval)).to eq expected
    end
  end

  describe '#validate_start' do
    let(:start) { Time.new(2016, 1, 1, 12, 0, 0) }

    context 'when #start is nil' do
      before(:each) do
        allow(subject).to receive(:start).and_return(nil)
      end

      it 'returns nil' do
        actual = subject.send(:validate_start)
        expect(actual).to be_nil
      end
    end

    context 'when start time is outside of regular business hours' do
      before(:each) do
        allow(subject).to receive(:start?).and_return(true)
        allow(subject)
          .to receive(:start_time_within_regular_business_hours?)
          .and_return(false)
        subject.send(:validate_start)
      end

      it 'adds an error to the :start attribute' do
        actual = subject.errors[:start]
        expect(actual).not_to be_empty
      end
    end

    context 'when start time is inside of regular business hours' do
      before(:each) do
        allow(subject).to receive(:start?).and_return(true)
        allow(subject)
          .to receive(:start_time_within_regular_business_hours?)
          .and_return(true)
        subject.send(:validate_start)
      end

      it 'does not have any errors on :start attribute' do
        actual = subject.errors[:start]
        expect(actual).to be_empty
      end
    end
  end

  describe '#start_time_within_regular_business_hours?' do
    let(:earliest_start) { double('earliest_start') }
    let(:latest_start)   { double('latest_start') }

    before(:each) do
      allow(described_class)
        .to receive(:earliest_start)
        .and_return(earliest_start)
      allow(described_class).to receive(:latest_start).and_return(latest_start)
      allow(earliest_start).to receive(:second_of_day).and_return(100)
      allow(latest_start).to receive(:second_of_day).and_return(200)
    end

    context 'when start time is before earliest_start' do
      before(:each) do
        allow(subject)
          .to receive(:start_time_seconds_since_midnight)
          .and_return(99)
      end

      it 'returns false' do
        actual = subject.send(:start_time_within_regular_business_hours?)
        expect(actual).to be_falsey
      end
    end
    context 'when start time is ON earliest_start' do
      before(:each) do
        allow(subject)
          .to receive(:start_time_seconds_since_midnight)
          .and_return(earliest_start.second_of_day)
      end

      it 'returns true' do
        actual = subject.send(:start_time_within_regular_business_hours?)
        expect(actual).to be_truthy
      end
    end
    context 'when start time is after earliest_start but before latest_start' do
      before(:each) do
        allow(subject)
          .to receive(:start_time_seconds_since_midnight)
          .and_return(150)
      end

      it 'returns true' do
        actual = subject.send(:start_time_within_regular_business_hours?)
        expect(actual).to be_truthy
      end
    end
    context 'when start time is ON latest_start' do
      before(:each) do
        allow(subject)
          .to receive(:start_time_seconds_since_midnight)
          .and_return(latest_start.second_of_day)
      end

      it 'returns true' do
        actual = subject.send(:start_time_within_regular_business_hours?)
        expect(actual).to be_truthy
      end
    end
    context 'when start time is after earliest_start & after latest_start' do
      before(:each) do
        allow(subject)
          .to receive(:start_time_seconds_since_midnight)
          .and_return(201)
      end

      it 'returns false' do
        actual = subject.send(:start_time_within_regular_business_hours?)
        expect(actual).to be_falsey
      end
    end
  end

  describe '#start_time_seconds_since_midnight' do
    let(:start) { double('time') }

    before(:each) do
      allow(subject).to receive(:start).and_return(start)
      allow(start).to receive(:seconds_since_midnight).and_return(123.45)
    end

    it 'converts the number of seconds since midnight to an integer' do
      actual = subject.send(:start_time_seconds_since_midnight)
      expect(actual).to eq 123
    end
  end

  describe '#validate_people_availability' do
    context 'qualifying necessary attributes' do
      context 'when #enrollment_id is nil' do
        before(:each) do
          allow(subject).to receive(:enrollment_id?).and_return(false)
        end

        it 'returns nil' do
          actual = subject.send(:validate_people_availability)
          expect(actual).to be_nil
        end
      end

      context 'when #start is nil' do
        before(:each) do
          allow(subject).to receive(:enrollment_id?).and_return(true)
          allow(subject).to receive(:start?).and_return(false)
        end

        it 'returns nil' do
          actual = subject.send(:validate_people_availability)
          expect(actual).to be_nil
        end
      end

      context 'when #length is nil' do
        before(:each) do
          allow(subject).to receive(:enrollment_id?).and_return(true)
          allow(subject).to receive(:start?).and_return(true)
          allow(subject).to receive(:length?).and_return(false)
        end

        it 'returns nil' do
          actual = subject.send(:validate_people_availability)
          expect(actual).to be_nil
        end
      end
    end

    context 'otherwise' do
      let(:start) { Time.new(2016, 1, 1, 12, 0, 0) }

      before(:each) do
        allow(subject).to receive(:enrollment_id?).and_return(true)
        allow(subject).to receive(:start?).and_return(true)
        allow(subject).to receive(:length?).and_return(true)
        allow(subject).to receive(:start).and_return(start)
      end

      context 'when teacher is already scheduled' do
        before(:each) do
          allow(subject).to receive(:teacher_scheduled?).and_return(true)
          allow(subject).to receive(:student_scheduled?).and_return(false)
          subject.valid?
        end

        it 'adds error to :base' do
          actual = subject.errors
          expect(actual).not_to be_empty
        end
        it 'mentions Teacher in the message' do
          actual = subject.errors.messages[:base][0]
          expect(actual).to match(/teacher/i)
        end
      end

      context 'when student is already scheduled' do
        before(:each) do
          allow(subject).to receive(:teacher_scheduled?).and_return(false)
          allow(subject).to receive(:student_scheduled?).and_return(true)
          subject.valid?
        end

        it 'adds error to :base' do
          actual = subject.errors
          expect(actual).not_to be_empty
        end
        it 'mentions Student in the message' do
          actual = subject.errors.messages[:base][0]
          expect(actual).to match(/student/i)
        end
      end
    end
  end

  describe '#teacher_scheduled?' do
    let(:teacher) { build(:person) }
    let(:start) { 'start' }
    let(:stop)  { 'stop' }

    before(:each) do
      allow(enrollment).to receive(:teacher).and_return(teacher)
      allow(subject).to receive(:enrollment).and_return(enrollment)
      allow(subject).to receive(:start).and_return(start)
      allow(subject).to receive(:stop).and_return(stop)
    end

    context 'expected method calls' do
      before(:each) do
        allow(teacher).to receive(:scheduled?)
      end
      after(:each) do
        subject.send(:teacher_scheduled?)
      end

      it 'loads the teacher on the enrollment' do
        expect(enrollment).to receive(:teacher)
      end
      it 'calls #scheduled? on the teacher' do
        expect(teacher).to receive(:scheduled?).with(start, stop)
      end
    end

    context 'when teacher is scheduled' do
      before(:each) do
        allow(teacher).to receive(:scheduled?).and_return(true)
      end

      it 'returns true' do
        actual = subject.send(:teacher_scheduled?)
        expect(actual).to be_truthy
      end
    end

    context 'when teacher is NOT scheduled' do
      before(:each) do
        allow(teacher).to receive(:scheduled?).and_return(false)
      end

      it 'returns false' do
        actual = subject.send(:teacher_scheduled?)
        expect(actual).to be_falsey
      end
    end
  end

  describe '#student_scheduled?' do
    let(:student) { build(:person) }
    let(:start) { 'start' }
    let(:stop)  { 'stop' }

    before(:each) do
      allow(enrollment).to receive(:student).and_return(student)
      allow(subject).to receive(:enrollment).and_return(enrollment)
      allow(subject).to receive(:start).and_return(start)
      allow(subject).to receive(:stop).and_return(stop)
    end

    context 'expected method calls' do
      before(:each) do
        allow(student).to receive(:scheduled?)
      end
      after(:each) do
        subject.send(:student_scheduled?)
      end

      it 'loads the student on the enrollment' do
        expect(enrollment).to receive(:student)
      end
      it 'calls #scheduled? on the student' do
        expect(student).to receive(:scheduled?).with(start, stop)
      end
    end

    context 'when student is scheduled' do
      before(:each) do
        allow(student).to receive(:scheduled?).and_return(true)
      end

      it 'returns true' do
        actual = subject.send(:student_scheduled?)
        expect(actual).to be_truthy
      end
    end

    context 'when student is NOT scheduled' do
      before(:each) do
        allow(student).to receive(:scheduled?).and_return(false)
      end

      it 'returns false' do
        actual = subject.send(:student_scheduled?)
        expect(actual).to be_falsey
      end
    end
  end
end
