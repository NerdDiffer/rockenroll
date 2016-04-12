require 'rails_helper'

describe Person do
  subject { build(:person) }
  let(:lesson_1) { build(:meeting) }
  let(:lesson_2) { build(:meeting) }

  describe '#enrollments' do
    before(:each) do
      allow(subject).to receive(:id).and_return(1)
      allow(Enrollment).to receive(:enrollments_for_person)
    end
    after(:each) do
      subject.enrollments
    end

    it 'calls #enrollments_for_person on Enrollment' do
      expect(Enrollment).to receive(:enrollments_for_person).with(1)
    end
  end

  describe '#courses' do
    before(:each) do
      allow(subject).to receive(:id).and_return(1)
      allow(Course).to receive(:courses_for_person)
    end
    after(:each) do
      subject.courses
    end

    it 'calls #courses_for_person on Course' do
      expect(Course).to receive(:courses_for_person).with(1)
    end
  end

  describe '#lessons' do
    before(:each) do
      allow(subject).to receive(:id).and_return(1)
      allow(Meeting).to receive(:lessons_for_person)
    end
    after(:each) do
      subject.lessons
    end

    it 'calls #lessons_for_person on Meeting' do
      expect(Meeting).to receive(:lessons_for_person).with(1)
    end
  end

  describe '#lessons_within' do
    before(:each) do
      stub_lessons
    end

    it 'returns first lesson' do
      lower_bound = '2016-04-10 12:00:00'
      upper_bound = '2016-04-23 12:00:00'

      actual = subject.lessons_within(lower_bound, upper_bound)

      expect(actual).to eq [lesson_1]
    end

    it 'returns second lesson' do
      lower_bound = '2016-04-18 12:00:00'
      upper_bound = '2016-04-24 12:00:00'

      actual = subject.lessons_within(lower_bound, upper_bound)

      expect(actual).to eq [lesson_2]
    end

    it 'returns both lessons' do
      lower_bound = '2016-04-10 12:00:00'
      upper_bound = '2016-05-01 12:00:00'

      actual = subject.lessons_within(lower_bound, upper_bound)

      expect(actual).to eq [lesson_1, lesson_2]
    end

    it 'returns neither lesson' do
      lower_bound = '2016-04-25 12:00:00'
      upper_bound = '2016-05-01 12:00:00'

      actual = subject.lessons_within(lower_bound, upper_bound)

      expect(actual).to eq []
    end
  end

  describe '#scheduled?' do
    before(:each) do
      stub_lessons
    end

    context 'when range includes lesson dates & times' do
      it 'returns true' do
        lower_bound = '2016-04-10 12:00:00'
        upper_bound = '2016-04-23 12:00:00'

        actual = subject.scheduled?(lower_bound, upper_bound)

        expect(actual).to be_truthy
      end
    end

    context 'when range does NOT include lesson dates & times' do
      it 'returns false' do
        lower_bound = '2016-04-25 12:00:00'
        upper_bound = '2016-05-01 12:00:00'

        actual = subject.scheduled?(lower_bound, upper_bound)

        expect(actual).to be_falsey
      end
    end
  end

  describe '#available?' do
    before(:each) do
      stub_lessons
    end

    context 'when range includes lesson dates & times' do
      it 'returns false' do
        lower_bound = '2016-04-10 12:00:00'
        upper_bound = '2016-04-23 12:00:00'

        actual = subject.available?(lower_bound, upper_bound)

        expect(actual).to be_falsey
      end
    end

    context 'when range does NOT include lesson dates & times' do
      it 'returns true' do
        lower_bound = '2016-04-25 12:00:00'
        upper_bound = '2016-05-01 12:00:00'

        actual = subject.available?(lower_bound, upper_bound)

        expect(actual).to be_truthy
      end
    end
  end

  describe '#overlaps?' do
    let(:lesson) { build(:meeting) }

    before(:each) do
      allow(lesson).to receive(:overlaps?)
    end
    after(:each) do
      subject.send(:overlaps?, lesson, :lower_bound, :upper_bound)
    end

    it 'calls #overlaps? on the lesson object' do
      expect(lesson).to receive(:overlaps?).with(:lower_bound, :upper_bound)
    end
  end

  private

  def stub_lessons
    allow(lesson_1).to receive(:start).and_return('2016-04-17 12:00:00')
    allow(lesson_1).to receive(:length).and_return('30')
    allow(lesson_1).to receive(:stop).and_return('2016-04-17 12:30:00')

    allow(lesson_2).to receive(:start).and_return('2016-04-24 12:00:00')
    allow(lesson_2).to receive(:length).and_return('90')
    allow(lesson_2).to receive(:stop).and_return('2016-04-24 13:30:00')

    allow(subject).to receive(:lessons).and_return([lesson_1, lesson_2])
  end
end
