require 'rails_helper'

describe Enrollment do
  subject { build(:enrollment) }
  let(:course)  { build(:course) }
  let(:teacher) { build(:person) }
  let(:student) { build(:person) }

  describe '.enrollments_for_person' do
    before(:each) do
      allow(described_class).to receive(:collection_for_person)
    end

    it 'calls .collection_for_person' do
      expect(described_class).to receive(:collection_for_person).with(1)
      described_class.enrollments_for_person(1)
    end
  end

  describe '._collection_for_person' do
    let(:relation) { double('relation') }

    before(:each) do
      allow(described_class)
        .to receive(:teacher_id_or_student_id_matches)
        .and_return(:foo)
      allow(described_class).to receive(:where).and_return(relation)
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
    it 'calls .where' do
      expect(described_class).to receive(:where).with(:foo)
    end
    it 'calls .distinct' do
      expect(relation).to receive(:distinct)
    end
  end

  describe '#different_teacher_and_student' do
    before(:each) do
      allow(subject).to receive(:course).and_return(course)
      allow(subject).to receive(:teacher).and_return(teacher)
      allow(subject).to receive(:student).and_return(student)
    end

    context 'when teacher & student are same Person records' do
      before(:each) do
        allow(subject).to receive(:teacher_and_student_same?).and_return(true)
        subject.valid?
      end

      it 'adds an error to the :base attribute' do
        actual = subject.errors[:base]
        expect(actual).not_to be_nil
      end
    end

    context 'when teacher & student are different Person records' do
      before(:each) do
        allow(subject).to receive(:teacher_and_student_same?).and_return(false)
      end

      it 'does NOT have any errors' do
        expect(subject.valid?).to be_truthy
      end
    end
  end

  describe '#teacher_and_student_same?' do
    context 'when teacher_id and student_id are equal' do
      before(:each) do
        allow(subject).to receive(:teacher_id).and_return(1)
        allow(subject).to receive(:student_id).and_return(1)
      end

      it 'returns true' do
        actual = subject.send(:teacher_and_student_same?)
        expect(actual).to be_truthy
      end
    end

    context 'when teacher_id and student_id are NOT equal' do
      before(:each) do
        allow(subject).to receive(:teacher_id).and_return(1)
        allow(subject).to receive(:student_id).and_return(2)
      end

      it 'returns false' do
        actual = subject.send(:teacher_and_student_same?)
        expect(actual).to be_falsey
      end
    end
  end
end
