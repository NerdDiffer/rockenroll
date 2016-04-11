require 'rails_helper'

describe Course do
  let(:user) { build(:user) }

  describe '.courses_for_person' do
    before(:each) do
      allow(described_class).to receive(:collection_for_person)
    end

    it 'calls .collection_for_person' do
      expect(described_class).to receive(:collection_for_person).with(1)
      described_class.courses_for_person(1)
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
      expect(described_class).to receive(:joins).with(:enrollments)
    end
    it 'calls .where' do
      expect(relation).to receive(:where).with(:foo)
    end
    it 'calls .distinct' do
      expect(relation).to receive(:distinct)
    end
  end
end
